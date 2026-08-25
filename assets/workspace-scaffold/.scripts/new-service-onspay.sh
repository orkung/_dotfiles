#!/usr/bin/env bash

set -euo pipefail

service_name="${1:?usage: new-service-onspay.sh <service-name> (e.g. onspay-billing-service)}"
template_dir=".templates/chart-service"
chart_dir="charts/${service_name}"

label='[a-z0-9]([a-z0-9-]*[a-z0-9])?'
name_re="^${label}\$"

if [[ ! "$service_name" =~ $name_re ]]; then
  printf 'service name must be a lowercase alphanumeric RFC 1123 label (letters, digits, internal dashes only), e.g. onspay-billing-service: %s\n' "$service_name" >&2
  exit 1
fi

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
  sed -e "s#__SERVICE_NAME__#${service_name}#g" -e "s#__IMAGE_NAME__#${service_name}#g" \
    "$src" >"$dest"
done

# DNS subdomains are registered without the "onspay-" prefix and without
# a trailing "-service" suffix (e.g. onspay-banking-client-service ->
# banking-client-dev.onspay.com) -- strip both for the ingress host only;
# __SERVICE_NAME__ keeps the full chart/service name everywhere else.
dns_name="${service_name#onspay-}"
dns_name="${dns_name%-service}"

for env in development test; do
  env_dir="environments/${env}/${service_name}"
  mkdir -p "$env_dir"
  sed -e "s#__SERVICE_NAME__#${service_name}#g" -e "s#__CHART_PATH__#${service_name}#g" \
    -e "s#__DNS_NAME__#${dns_name}#g" \
    "$template_dir/environments/${env}-values.yaml.template" >"$env_dir/values.yaml"
done

cat <<EOF
Created charts/${service_name}/ and environments/{development,test}/${service_name}/values.yaml

Next steps:
  1. Adjust charts/${service_name}/values.yaml (ports, resources) and the
     two environments/*/${service_name}/values.yaml overrides as needed.
  2. Stage the new files (templates/ may be globally gitignored, force-add it):
       git add charts/${service_name}/Chart.yaml
       git add charts/${service_name}/values.yaml
       git add -f charts/${service_name}/templates/
       git add environments/development/${service_name}/values.yaml
       git add environments/test/${service_name}/values.yaml
  3. Commit and push. No apps/ changes are needed - the ApplicationSet whose
     git generator covers charts/${service_name}/ picks up the new folder on
     its next reconcile.
EOF
