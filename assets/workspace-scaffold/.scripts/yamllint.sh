#!/usr/bin/env sh
# Run yamllint with the repository rules and ignore patterns.
# Usage: ./.scripts/yamllint.sh [path ...]

set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
repo_root=$(dirname -- "$script_dir")

if ! command -v yamllint >/dev/null 2>&1; then
  echo "yamllint is required; install it with: pipx install yamllint" >&2
  exit 127
fi

if [ "$#" -eq 0 ]; then
  set -- "."
fi

cd "$repo_root"
exec yamllint --config-file "$repo_root/.yamllint.json" "$@"
