#!/usr/bin/env sh
# Run shellcheck against the given shell script paths.
# Usage: ./.scripts/shellcheck.sh <path>...

set -eu

if ! command -v shellcheck >/dev/null 2>&1; then
  echo "shellcheck is required; install it with: apt-get install shellcheck" >&2
  exit 127
fi

exec shellcheck "$@"
