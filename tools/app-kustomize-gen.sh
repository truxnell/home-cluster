#!/bin/bash
shopt -s extglob

ROOT=$(git rev-parse --show-toplevel)
K8S_ROOT="$ROOT/kubernetes/apps"

for DIR in $K8S_ROOT/*/
do
  echo "Processing $DIR"

  if [ ! -f "$DIR/namespace.yaml" ]; then

      echo "$DIR missing namespace, creating"

      ns=$(basename $DIR)
      export NAMESPACE=$ns

      envsubst < "$ROOT/templates/namespace/namespace.yaml" > "$DIR/namespace.yaml"

  fi

  envsubst < "$ROOT/templates/namespace/kustomization.yaml" > "$DIR/kustomization.yaml"

  for FILE in $DIR*.yaml
  do

    if [ ! $(basename $FILE) == "kustomization.yaml" ] && [ ! $(basename $FILE) == "namespace.yaml" ]; then
      echo "  - ./$FILE" >>   "$DIR/kustomization.yaml"
    fi

  done

  for APP in $DIR*/
  do
    APP_NAME=$(basename $APP)
    echo " Adding $APP_NAME to $FILE"
    if [ ! -f "$APP/ks.yaml" ]; then

      echo "WARN:: $APP_NAME is missing its ks.yaml"

    elif [ -f "$APP/wip" ]; then

      echo "WARN:: $APP_NAME has a wip file, adding commented"
      echo "  # - ./$APP_NAME/ks.yaml" >>   "$DIR/kustomization.yaml"

    else

      echo "  - ./$APP_NAME/ks.yaml" >>   "$DIR/kustomization.yaml"

    fi


    appname=$(basename "$DIR")
    ns=$(basename $(dirname "$DIR"))

    export FULLDIR="./$K8S_FOLDER/$ns/$APP_NAME"
    export APP_NAME=$appname
    envsubst < "$ROOT/templates/ks/ks.yaml" > "$dir/ks.yaml"

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

done;
