#!/usr/bin/env bash

set -euo pipefail

usage="usage: set-ingress.sh <service>|waas/<service>/<api> <env> <host> [ingressClassName]"
chart_path="${1:?$usage}"
env_name="${2:?$usage}"
host="${3:?$usage}"
class_name="${4:-nginx}"

values_file="environments/${env_name}/${chart_path}/values.yaml"

if [[ ! -f "$values_file" ]]; then
  printf 'values file not found: %s\n' "$values_file" >&2
  exit 1
fi

# Escape sed metacharacters so an arbitrary host/class can't break the
# substitution or inject extra sed commands.
escaped_host=$(printf '%s' "$host" | sed -e 's/[\&#]/\\&/g')
escaped_class=$(printf '%s' "$class_name" | sed -e 's/[\&#]/\\&/g')

if grep -qE '^ingress:[[:space:]]*$' "$values_file"; then
  sed -i -E "s#^([[:space:]]*host:[[:space:]]*).*#\1${escaped_host}#" \
    "$values_file"
  sed -i -E "s#^([[:space:]]*className:[[:space:]]*).*#\1${escaped_class}#" \
    "$values_file"
  printf 'updated ingress.host=%s and ingress.className=%s in %s\n' \
    "$host" "$class_name" "$values_file"
else
  {
    printf '\n'
    printf 'ingress:\n'
    printf '  className: %s\n' "$class_name"
    printf '  host: %s\n' "$host"
  } >>"$values_file"
  printf 'added ingress.host=%s and ingress.className=%s to %s\n' \
    "$host" "$class_name" "$values_file"
fi
