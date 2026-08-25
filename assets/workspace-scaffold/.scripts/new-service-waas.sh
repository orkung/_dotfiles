#!/usr/bin/env bash

set -euo pipefail

usage="usage: new-service-waas.sh <service>/<api> <nexus-image-name> (e.g. usermodule/userapi waas-user-module-userapi)"
chart_path="${1:?$usage}"
image_name="${2:?$usage}"
template_dir=".templates/chart-service"
chart_dir="charts/waas/${chart_path}"

label='[a-z0-9]([a-z0-9-]*[a-z0-9])?'
path_re="^${label}/${label}\$"
image_re="^${label}\$"

if [[ ! "$chart_path" =~ $path_re ]]; then
  printf 'expected exactly <service>/<api>, each a lowercase alphanumeric RFC 1123 label (letters, digits, internal dashes only), e.g. usermodule/userapi: %s\n' "$chart_path" >&2
  exit 1
fi

if [[ ! "$image_name" =~ $image_re ]]; then
  printf 'nexus image name must be a lowercase alphanumeric RFC 1123 label (letters, digits, internal dashes only), e.g. waas-user-module-userapi: %s\n' "$image_name" >&2
  exit 1
fi

api_name="${chart_path//\//-}"

if [[ -e "$chart_dir" ]]; then
  printf 'chart already exists: %s\n' "$chart_dir" >&2
  exit 1
fi

if [[ ! -d "$template_dir" ]]; then
  printf 'template dir not found: %s\n' "$template_dir" >&2
  exit 1
fi

mkdir -p "$chart_dir/templates"

shopt -s nullglob
for src in "$template_dir"/*.template "$template_dir"/templates/*.template; do
  rel="${src#"$template_dir"/}"
  dest="$chart_dir/${rel%.template}"
  sed -e "s#__SERVICE_NAME__#${api_name}#g" -e "s#__IMAGE_NAME__#${image_name}#g" \
    "$src" >"$dest"
done

for env in development test; do
  env_dir="environments/${env}/waas/${chart_path}"
  mkdir -p "$env_dir"
  sed -e "s#__SERVICE_NAME__#${api_name}#g" -e "s#__CHART_PATH__#waas/${chart_path}#g" \
    "$template_dir/environments/${env}-values.yaml.template" >"$env_dir/values.yaml"
done

cat <<EOF
Created charts/waas/${chart_path}/ and
environments/{development,test}/waas/${chart_path}/values.yaml
image.repository is set to nexus.onspay.com/docker-hosted/${image_name}

This scaffolds one API of a multi-API waas monolith: each API under a
service gets its own chart, container image, and Application, so
usermodule/userapi and usermodule/adminapi deploy as separate pods.
environments/ mirrors the chart path here (waas/<service>/<api>) rather
than staying flat, so API names only need to be unique within their
service, not repo-wide.

Next steps:
  1. Adjust charts/waas/${chart_path}/values.yaml (ports, resources) and
     the two environments/*/waas/${chart_path}/values.yaml overrides as
     needed.
  2. Stage the new files (templates/ may be globally gitignored, force-add it):
       git add charts/waas/${chart_path}/Chart.yaml
       git add charts/waas/${chart_path}/values.yaml
       git add -f charts/waas/${chart_path}/templates/
       git add environments/development/waas/${chart_path}/values.yaml
       git add environments/test/waas/${chart_path}/values.yaml
  3. Commit and push. No apps/ changes are needed - apps/development/appset-waas.yaml
     already watches charts/waas/*/* for nested per-API charts and resolves
     environments/<env>/waas/<service>/<api>/values.yaml automatically.
EOF
