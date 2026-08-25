#!/usr/bin/env bash
# Local, no-cluster-access validation for the healthchecks-operator chart
# and its Argo CD Application: helm lint, helm template, yamllint, and a
# client-side kubectl dry-run (which will report the HealthCheck CR as
# an unknown kind on a fresh cluster -- expected, since the CRD it
# depends on doesn't exist yet either; that's what the chart's
# argocd.argoproj.io/sync-wave annotations resolve at apply time).
#
# Usage: ./.scripts/verify-healthchecks-operator.sh [env]
#   env defaults to "development" (the only environment this component
#   is currently onboarded to -- see apps/development/
#   healthchecks-operator.yaml).

set -euo pipefail

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
repo_root=$(dirname -- "$script_dir")
cd "$repo_root"

env_name="${1:-development}"
chart_dir="charts/healthchecks-operator"
values_file="environments/${env_name}/healthchecks-operator/values.yaml"
app_file="apps/${env_name}/healthchecks-operator.yaml"

for tool in helm yamllint kubectl; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    printf '%s is required but not on PATH\n' "$tool" >&2
    exit 127
  fi
done

if [[ ! -f "$values_file" ]]; then
  printf 'values file not found: %s\n' "$values_file" >&2
  exit 1
fi

if [[ ! -f "$app_file" ]]; then
  printf 'Application manifest not found: %s\n' "$app_file" >&2
  exit 1
fi

printf '==> helm lint %s\n' "$chart_dir"
helm lint "$chart_dir"

printf '\n==> helm template (%s)\n' "$env_name"
rendered=$(mktemp)
dry_run_output=$(mktemp)
trap 'rm -f "$rendered" "$dry_run_output"' EXIT
helm template "healthchecks-operator-${env_name}" "$chart_dir" \
  -f "$values_file" \
  --namespace healthchecks \
  >"$rendered"
printf 'rendered %s lines\n' "$(wc -l <"$rendered")"

printf '\n==> kubectl apply --dry-run=client\n'
if ! kubectl apply --dry-run=client -f "$rendered" >"$dry_run_output" 2>&1; then
  if grep -q 'no matches for kind "HealthCheck"' "$dry_run_output"; then
    cat "$dry_run_output"
    printf '(expected: the target cluster does not have the CRD installed yet,\n'
    printf 'so client-side discovery cannot resolve the HealthCheck kind. The\n'
    printf "chart's sync-wave ordering (CRD at -2, CR at 1) is what makes this\n"
    printf 'resolve for real on an Argo CD sync -- not a failure of this check.)\n'
  else
    cat "$dry_run_output" >&2
    exit 1
  fi
else
  cat "$dry_run_output"
fi

printf '\n==> yamllint\n'
yamllint --config-file .yamllint.json "$chart_dir" "$values_file" "$app_file"

printf '\n==> yamllint apps/%s/appset-microservices.yaml (exclude entry)\n' "$env_name"
yamllint --config-file .yamllint.json "apps/${env_name}/appset-microservices.yaml"

printf '\nAll local checks passed for env=%s.\n' "$env_name"
