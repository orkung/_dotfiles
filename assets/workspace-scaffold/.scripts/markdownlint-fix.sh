#!/usr/bin/env sh

set -eu

script_dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
repo_root=$(dirname "$script_dir")
cd "$repo_root"

if [ "$#" -eq 0 ]; then
  set -- '**/*.md'
fi

# Prettier automatically formats Markdown: wraps lines (MD013),
# standardizes list formatting (MD004/MD007), and normalizes spacing.
npx -y prettier \
  --prose-wrap always \
  --print-width 70 \
  --no-error-on-unmatched-pattern \
  --write \
  "$@"

# markdownlint-cli2 applies any remaining fixable rules and reports final status.
exec npx -y markdownlint-cli2 \
  --config .markdownlint.json \
  --fix \
  "$@"

