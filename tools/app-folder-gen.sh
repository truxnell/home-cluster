#!/bin/bash
shopt -s extglob

ROOT=$(git rev-parse --show-toplevel)
K8S_FOLDER="kubernetes/apps"

echo "Processing folder $1 for heirachy"

for dir in $ROOT/$K8S_FOLDER/$1/*/
do
  if [ ! -d "$dir" ]; then
    echo "$dir doesn't exist, aborting"
    exit;
  fi
  if [ ! -d "$dir/app" ]; then
    echo "creating app folder for $dir"
    mkdir "$dir/app"
    mv $dir/!(app) "$dir/app"
  fi
    appname=$(basename "$dir")
    ns=$(basename $(dirname "$dir"))

    export FULLDIR="./$K8S_FOLDER/$ns/$appname"
    export APP_NAME=$appname
    envsubst < "$ROOT/templates/ks/ks.yaml" > "$dir/ks.yaml"


done;
