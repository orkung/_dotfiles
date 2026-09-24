#!/usr/bin/env sh
# Run markdownlint-cli2 using the repo's CLI config and ignore patterns.
# Usage: ./scripts/markdownlint.sh <path>...

npx -y markdownlint-cli2 --config .markdownlint-cli2.json "$@"
