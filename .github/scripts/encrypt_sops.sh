#!/bin/bash
set -e

# Script to recursively scan all flux cluster folders ending in *.sops
# and create a sops encrypted yaml from them

# Script liberated and heavily modified from bjw's repo at
# https://github.com/bjw-s/k8s-gitops/blob/main/.github/scripts/render_templates.sh

REPO_ROOT=$(git rev-parse --show-toplevel)
OPERATOR_ROOT="${REPO_ROOT}/operators"
INFRASTRUCTURE_ROOT="${REPO_ROOT}/infrastructure"
APPS_ROOT="${REPO_ROOT}/apps"
CLUSTER_ROOT="${REPO_ROOT}/cluster"

while getopts i:r option
do
  case "${option}" in
  i) INPUT_FILE=${OPTARG};;
  *) echo "usage: $0 [-m] [-r]" >&2 && exit 1
 esac
done

need() {
    command -v "$1" &>/dev/null || (echo "Binary '$1' is missing but required" && exit 1)
}

need "kubectl"
need "sops"

message() {
  echo -e "\n######################################################################"
  echo "# $1"
  echo "######################################################################"
}

FILES_TO_PROCESS=$(find "${OPERATOR_ROOT}" -type f -name "*.sops")
FILES_TO_PROCESS="${FILES_TO_PROCESS}
$(find "${INFRASTRUCTURE_ROOT}" -type f -name "*.sops")"
FILES_TO_PROCESS="${FILES_TO_PROCESS}
$(find "${APPS_ROOT}" -type f -name "*.sops")"
FILES_TO_PROCESS="${FILES_TO_PROCESS}
$(find "${CLUSTER_ROOT}" -type f -name "*.sops")"


message "Files to process: ${FILES_TO_PROCESS}"

message "Processing sops files and outputting encrypted yaml in same folder"

# Loop over the files that should be processed
while IFS= read -r file; do
  # Convert relative paths to absolute paths
  if [[ "$file" != /* ]]; then
    file="$REPO_ROOT/$file"
  fi

  # Only process .tmpl files
  if [[ $file != ${CLUSTER_ROOT}*.sops ]]; then
    continue
  fi

  # # Get secret file metadata (path, filename, etc...)
  template_filename="${file##*/}"
  template_path="${file%/$template_filename}"
  template_relative_path=${template_path#"${CLUSTER_ROOT}"}
  template_target_name="${template_filename}.yaml"

  # # Determine secret namespace / deployment
  IFS="/" read -ra template_relative_path_arr <<< "$template_relative_path"
  template_base=${template_relative_path_arr[1]}
  template_namespace=${template_relative_path_arr[2]}
  template_deployment=${template_relative_path_arr[3]}

  echo "- Processing $file"

  # Double check to see if the file exists
  if [[ ! -f "$file" ]]; then
    echo "  ${file} does not exist. Aborting"
    exit 1
  fi

  encrypted_file=$(sops --input-type yaml --output-type yaml --encrypt $file)

  # Output the file to the desired path
  echo "$encrypted_file" > "${template_path}/$template_target_name"

done <<< "$FILES_TO_PROCESS"

message "Completed!"
