#!/bin/bash
shopt -s extglob

ROOT=$(git rev-parse --show-toplevel)

for dir in $1/*/
do
  if [ ! -d "$dir" ]; then
    echo "$dir doesn't exist, aborting"
    exit;
  fi
  if [ ! -d "$dir/app" ]; then
    echo "creating app folder for $dir"
    mkdir "$dir/app"
    mv $dir/!(app) "$dir/app"
    appname=$(basename "$dir")
    ns=$(basename $(dirname "$dir"))

    export FULLDIR="$dir"
    export APP_NAME=$appname
    export NAMESPACE=$ns
    envsubst < "$ROOT/templates/ks/ks.yaml" > "$dir/ks.yaml"

  fi

done;
