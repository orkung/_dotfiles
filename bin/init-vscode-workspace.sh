#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<'EOF'
Usage: init-vscode-workspace.sh <target-directory> [<repo-root>]

Create a new VS Code workspace under the given target directory.
The script copies shared workspace support files from the repo root and
generates a .code-workspace file.

Arguments:
  target-directory  Path to the new project directory to create.
  repo-root         Optional path to the repo root containing the shared
                    workspace support files. If omitted, the script will
                    try to detect it from the current directory or git repo.

Examples:
  init-vscode-workspace.sh ~/projects/new-project
  init-vscode-workspace.sh ~/projects/new-project $HOME/projects/personal/yapilacaklar
  REPO_ROOT=$HOME/projects/personal/yapilacaklar init-vscode-workspace.sh ~/projects/new-project
EOF
  exit 1
}

if [[ $# -lt 1 ]]; then
  usage
fi

target="$1"
repo_root="${2:-}"
open_workspace=true
if [[ "${3:-}" == "--no-open" || "${2:-}" == "--no-open" ]]; then
  open_workspace=false
fi

if [[ "$target" == ~* ]]; then
  target="${HOME}${target:1}"
fi

if [[ "$repo_root" == ~* ]]; then
  repo_root="${HOME}${repo_root:1}"
fi

if [[ -z "$repo_root" && -n "${REPO_ROOT:-}" ]]; then
  repo_root="$REPO_ROOT"
fi

if [[ -z "$repo_root" ]]; then
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    repo_root="$(git rev-parse --show-toplevel 2>/dev/null)"
  fi
fi

if [[ -z "$repo_root" ]]; then
  candidate="$script_dir/.."
  if [[ -f "$candidate/.markdownlint.json" || -d "$candidate/.git" ]]; then
    repo_root="$(cd "$candidate" && pwd)"
  fi
fi

if [[ -z "$repo_root" ]]; then
  printf 'Error: could not determine repo root.\n' >&2
  printf 'Pass it as the second argument or set REPO_ROOT=.\n' >&2
  usage
fi

if [[ ! -d "$repo_root" ]]; then
  printf 'Error: repo root does not exist: %s\n' "$repo_root" >&2
  exit 1
fi

mkdir -p "$(dirname "$target")"
target="$(cd "$(dirname "$target")" && pwd)/$(basename "$target")"
mkdir -p "$target"

printf 'Initializing workspace in %s\n' "$target"

cp -R -n \
  "$repo_root/.markdownlint.json" \
  "$repo_root/.markdownlint-cli2.json" \
  "$repo_root/.yamllint.json" \
  "$repo_root/.pre-commit-config.yaml" \
  "$repo_root/.schemas" \
  "$repo_root/.vscode" \
  "$repo_root/.scripts" \
  "$repo_root/.templates" \
  "$repo_root/.docs" \
  "$target/"


workspace_name="$(basename "$target")"
cd "$target"

bash "$repo_root/.scripts/create-code-workspace.sh" \
  "$repo_root/.templates/mytemplate.code-workspace.template.json" \
  "$workspace_name" "."
workspace_file="$target/.$workspace_name.code-workspace"
mv "${workspace_name}.code-workspace" "$workspace_file"

printf 'Created %s\n' "$workspace_file"

if [[ "$open_workspace" == true ]]; then
  if command -v code >/dev/null 2>&1; then
    code "$workspace_file"
  else
    printf 'VS Code CLI not found. Run `code --install-extension` or open the workspace file manually.\n'
  fi
fi
