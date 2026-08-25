#!/usr/bin/env bash

set -euo pipefail

usage="usage: update-image-tag.sh <service>|waas/<service>/<api> <env> <tag>"
chart_path="${1:?$usage}"
env_name="${2:?$usage}"
new_tag="${3:?$usage}"

values_file="environments/${env_name}/${chart_path}/values.yaml"

if [[ ! -f "$values_file" ]]; then
  printf 'values file not found: %s\n' "$values_file" >&2
  exit 1
fi

if ! grep -qE '^[[:space:]]*tag:[[:space:]]*".*"[[:space:]]*$' "$values_file"; then
  printf 'no image tag: "..." line found in %s\n' "$values_file" >&2
  exit 1
fi

# Escape sed metacharacters so an arbitrary tag (branch name, sha, semver)
# can't break the substitution or inject extra sed commands.
escaped_tag=$(printf '%s' "$new_tag" | sed -e 's/[\&#]/\\&/g')

sed -i -E "s#^([[:space:]]*tag:[[:space:]]*).*#\1\"${escaped_tag}\"#" "$values_file"

printf 'set image.tag=%s in %s\n' "$new_tag" "$values_file"
