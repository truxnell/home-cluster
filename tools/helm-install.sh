#!/bin/bash

entry() {

    echo "Performing $OPERATION of helm chart $SOURCE/$CHART named $NAME, version $VERSION into namespace 'testing' using values from $FILE"
    case "$OPERATION" in
    install)
        yq -r .spec.values $FILE | helm install $NAME $SOURCE/$CHART --version $VERSION -n testing -f -
        ;;
    upgrade)
        yq -r .spec.values $FILE | helm upgrade $NAME $SOURCE/$CHART --version $VERSION -n testing -f -
        ;;
    delete)
        helm uninstall $NAME -n testing
        ;;
    template)
        yq -r .spec.values $FILE | helm template $NAME $SOURCE/$CHART --version $VERSION -n testing -f -
        ;;
    esac

}

show_help() {
    cat <<EOF
Usage: $(basename "$0") <command> <file>
    -i or --install   - install helm to cluster with file's values
    -t or --template  - render helm template with specified files values
    -d or --delete    - delete helm from cluser
EOF
}

parse_command_line() {

    while :; do
        case "${1:-}" in
        -h | --help)
            show_help
            exit 1
            ;;
        -f | --file)
            if [[ -n "${2:-}" ]]; then
                FILE="$2"
                shift
            else
                echo "ERROR: '-f|--file' cannot be empty." >&2
                show_help
                exit 1
            fi
            ;;
        -i | --install)
            OPERATION="install"
            ;;
        -u | --upgrade)
            OPERATION="upgrade"
            ;;
        -t | --template)
            OPERATION="template"
            ;;
        -d | --delete)
            OPERATION="delete"
            ;;
        -* | --*)
            echo "ERROR: Unknown option $1"
            show_help
            exit 1
            ;;
        *)
            break
            ;;
        esac
        shift
    done

    if [ -z $OPERATION ]; then
        echo "ERROR: no operation requested (-t / -i / -d)"
        show_help
        exit 1
    fi

    if [ -z "$FILE" ]; then
        echo "ERROR: '-f|--file' cannot be empty."
        show_help
        exit 1
    fi

    FILENAME=$(basename "$FILE")

    if [ "$FILENAME" != "helmrelease.yaml" ]; then
        echo "ERROR: File '$FILENAME' is not 'helmrelase.yaml', exiting"
        show_help
        exit 1
    fi

    CHART="$(yq -r .spec.chart.spec.chart $FILE)"
    NAME="$(yq -r .metadata.name $FILE)"
    SOURCE="$(yq -r .spec.chart.spec.sourceRef.name $FILE | sed "s/-charts//")"
    VERSION="$(yq -r .spec.chart.spec.version $FILE)"

}

check() {
    command -v "${1}" >/dev/null 2>&1 || {
        echo >&2 "ERROR: ${1} is not installed or not found in \$PATH" >&2
        exit 1
    }
}

main() {
    local CHART=
    local NAME=
    local SOURCE=
    local OPERATION=
    local VERSION=
    parse_command_line "$@"
    check "jq"
    check "yq"
    entry
}

main "$@"
