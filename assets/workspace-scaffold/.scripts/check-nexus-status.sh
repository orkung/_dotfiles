#!/usr/bin/env bash
set -u

URL="${1:-https://nexus.onspay.com}"
INTERVAL_SECONDS="${INTERVAL_SECONDS:-5}"
TIMEOUT_SECONDS="${TIMEOUT_SECONDS:-10}"

while true; do
  http_code="$(
    curl \
      --location \
      --silent \
      --show-error \
      --output /dev/null \
      --write-out "%{http_code}" \
      --max-time "${TIMEOUT_SECONDS}" \
      "${URL}" 2>/dev/null
  )"
  curl_status=$?

  if [[ "${curl_status}" -eq 0 && "${http_code}" == "200" ]]; then
    printf '%s status: %s\n' \
      "$(date --iso-8601=seconds)" \
      "${http_code}"
  fi

  sleep "${INTERVAL_SECONDS}"
done
