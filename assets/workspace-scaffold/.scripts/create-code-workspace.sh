#!/usr/bin/env bash

set -euo pipefail

template="${1:-templates/mytemplate.code-workspace.template.json}"
workspace_name="${2:-${PWD##*/}}"
folder_path="${3:-.}"
output_file="${workspace_name}.code-workspace"

if [[ ! -f "$template" ]]; then
  printf 'template not found: %s\n' "$template" >&2
  exit 1
fi

sed \
  -e "s#__WORKSPACE_NAME__#${workspace_name}#g" \
  -e "s#__FOLDER_PATH__#${folder_path}#g" \
  "$template" >"$output_file"

printf 'created %s from %s\n' "$output_file" "$template"
