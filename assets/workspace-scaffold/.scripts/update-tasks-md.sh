#!/usr/bin/env bash

set -euo pipefail

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
repo_root=$(git -C "$script_dir" rev-parse --show-toplevel)
tasks_file="$repo_root/tasks.md"
generated_date=$(date +%F)

status_output=$(git -C "$repo_root" status --short)

marker_output=''
if marker_output=$(cd "$repo_root" && rg --line-number --hidden --no-ignore \
  --ignore-case \
  --glob '!tasks.md' \
  --glob '!.scripts/update-tasks-md.sh' \
  --glob '!**/.git/**' \
  --glob '!**/.venv/**' \
  --glob '!**/.remember/**' \
  --glob '!**/node_modules/**' \
  'TODO|FIXME|HACK|XXX' .); then
  marker_output=$(printf '%s\n' "$marker_output" | sed 's#^\./##')
elif [[ $? -eq 1 ]]; then
  marker_output=''
else
  printf 'failed to scan for task markers\n' >&2
  exit 1
fi

temporary_file=$(mktemp "${tasks_file}.tmp.XXXXXX")
trap 'rm -f "$temporary_file"' EXIT

{
  printf '# Tasks — %s\n\n' "$(basename "$repo_root")"
  printf '## TODO / FIXME / HACK / XXX\n\n'
  if [[ -n "$marker_output" ]]; then
    printf '%s\n' "$marker_output"
  else
    printf 'None found.\n'
  fi

  printf '\n\n## In Progress (uncommitted changes)\n\n'
  if [[ -n "$status_output" ]]; then
    while IFS= read -r status_line; do
      printf -- '- `%s`\n' "$status_line"
    done <<< "$status_output"
  else
    printf 'None found.\n'
  fi

  printf '\n\n_Generated %s_\n' "$generated_date"
} > "$temporary_file"

chmod 0644 "$temporary_file"
mv -- "$temporary_file" "$tasks_file"
trap - EXIT

printf 'updated %s\n' "$tasks_file"
