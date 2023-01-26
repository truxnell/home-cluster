#!/bin/bash
shopt -s extglob
shopt -s nullglob

EXT_SECRET_NAME="cluster-apps-external-secrets-operator"
ROOK_CEPH_NAME="cluster-apps-rook-ceph-cluster"

ROOT=$(git rev-parse --show-toplevel)
K8S_FOLDER="kubernetes/apps"
K8S_ROOT="$ROOT/$K8S_FOLDER"

DIR_GIT_CHANGED=$(git status --porcelain | grep --color kubernetes/apps/ | cut -c4- | cut -d '/' -f 1,2,3 | uniq)
APP_GIT_CHANGED=$(git status --porcelain | grep --color kubernetes/apps/ | cut -c4- | cut -d '/' -f 1,2,3,4 | uniq)

for DIR in $DIR_GIT_CHANGED; do
    echo "Processing $DIR"

    ns=$(basename "$DIR")
    export NAMESPACE=$ns
    if [ ! -f "$DIR/namespace.yaml" ]; then

        echo "$DIR missing namespace, creating"

        ns=$(basename $DIR)
        export NAMESPACE=$ns

        envsubst <"$ROOT/templates/namespace/namespace.yaml" >"$DIR/namespace.yaml"

    fi

    envsubst <"$ROOT/templates/namespace/kustomization.yaml" >"$DIR/kustomization.yaml"

    for FILE in $DIR_GIT_CHANGED*.yaml; do

        if [ ! $(basename $FILE) == "kustomization.yaml" ] && [ ! $(basename $FILE) == "namespace.yaml" ]; then
            echo "  - ./$FILE" >>"$DIR/kustomization.yaml"
        fi

    done

    for APP in $APP_GIT_CHANGED*/; do
        APP_NAME=$(basename $APP)
        rm "$APP/ks.yaml"
        echo " Adding $APP_NAME to $FILE"
        if [ -f "$APP/wip" ]; then

            echo "WARN:: $APP_NAME has a wip file, adding commented"
            echo "  # - ./$APP_NAME/ks.yaml # TODO: Disabled by WIP file" >>"$DIR/kustomization.yaml"

        else

            echo "  - ./$APP_NAME/ks.yaml" >>"$DIR/kustomization.yaml"

        fi

        # Check all yaml for correct namespace
        for FILE in $APP*.yaml; do

            if [[ $(yq '.metadata.namespace') != null ]]; then
                echo "Ensuring namespace is $NAMESPACE in $FILE"
                yq -i '.metadata.namespace=strenv(NAMESPACE)' "$FILE"

            fi

        done

        section_num=0
        for SECTION in $APP/*/; do
            SECTION_NAME=$(basename "$SECTION")

            export FULLDIR="$K8S_ROOT/$ns/$APP_NAME/$SECTION_NAME"
            export APP_NAME=$APP_NAME
            export RELDIR="./$K8S_FOLDER/$ns/$APP_NAME/$SECTION_NAME"

            if [ $SECTION_NAME == "app" ]; then
                export HELM_NAME=$APP_NAME
            else

                export HELM_NAME="$APP_NAME-$SECTION_NAME"
            fi
            export SECTION_NAME=$SECTION_NAME

            echo "Adding $SECTION_NAME to $APP_NAME ks.yml ($APP_NAME || $SECTION_NAME)"
            envsubst <"$ROOT/templates/ks/ks.yaml" >>"$APP/ks.yaml"

            # If helmrelease present, add HR healthcheck and ensure values are aligned
            if [ -f "$SECTION/helmrelease.yaml" ]; then

                envsubst <"$ROOT/templates/ks/hr-add.yaml" >>"$APP/ks.yaml"
                yq -i '.metadata.namespace=strenv(NAMESPACE)' "$SECTION/helmrelease.yaml"
                yq -i '.metadata.name=strenv(HELM_NAME)' "$SECTION/helmrelease.yaml"

            fi
            # Check if deps to be added
            # loop through deps file and add
            echo "checking for file $FULLDIR/deps"
            if [ -f "$FULLDIR/deps" ]; then
                echo "Adding deps to $APP_NAME - $SECTION_NAME, doc id $section_num"
                while IFS= read -r line; do
                    if [ $line != "" ]; then
                        yq -i "(select(documentIndex==\"$section_num\")).spec.dependsOn += [{\"name\": \"$line\"}]" "$APP/ks.yaml"
                    fi
                done <"$FULLDIR/deps"
            fi

            # check if there is an externalsecret
            if [[ -n $(find "$FULLDIR" -type f -name "externalsecret.yaml") ]]; then
                echo "Externalsecret found - adding to deps"
                yq -i "(select(documentIndex==\"$section_num\")).spec.dependsOn += [{\"name\": \"$EXT_SECRET_NAME\"}]" "$APP/ks.yaml"
            fi

            # check if there is an externalsecret
            if [[ -n $(find "$FULLDIR" -type f -name "pvc.yaml") ]]; then
                echo "Externalsecret found - adding to deps"
                yq -i "(select(documentIndex==\"$section_num\")).spec.dependsOn += [{\"name\": \"$ROOK_CEPH_NAME\"}]" "$APP/ks.yaml"
            fi

            # Check all yaml for correct namespace
            for FILE in $SECTION*.yaml; do

                if [[ $(yq '.metadata.namespace' $file) != "null" && $(yq '.metadata.kind' $file) != "Secret" && $(yq '.metadata.kind' $file) != "Kustomization" ]]; then

                    echo "Ensuring namespace is $NAMESPACE in $FILE"
                    yq -i '.metadata.namespace=strenv(NAMESPACE)' "$FILE"

                fi

            done
            section_num=$((section_num + 1))
        done

        # if [ ! -d "$dir/app" ]; then
        #   echo "creating app folder for $dir"
        #   mkdir "$dir/app"
        #   mv $dir/!(app) "$dir/app"
        #   appname=$(basename "$dir")
        #   ns=$(basename $(dirname "$dir"))
        #
        #   export FULLDIR="$dir"
        #   export APP_NAME=$appname
        #   export NAMESPACE=$ns
        #   envsubst < "$ROOT/templates/ks/ks.yaml" > "$dir/ks.yaml"
        #
        #
        # fi
    done

done
