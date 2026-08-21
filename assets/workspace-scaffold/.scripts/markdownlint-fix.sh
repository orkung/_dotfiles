#!/usr/bin/env sh

set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
repo_root=$(dirname "$script_dir")
cd "$repo_root"

if [ "$#" -eq 0 ]; then
  set -- '**/*.md'
fi

exec npx -y markdownlint-cli2 \
  --config .markdownlint.json \
  --fix \
  "$@"
