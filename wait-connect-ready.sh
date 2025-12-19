#!/usr/bin/env bash
set -e

CONNECT_SERVICES=("connect1" "connect2" "connect3" "connect4")
READY_PATTERN="Finished starting connectors and tasks"

TIMEOUT_SECONDS=300
SLEEP_SECONDS=5

START_TIME=$(date +%s)

echo "=================================================="
echo "Waiting for Kafka Connect workers to be ready"
echo "Pattern: '$READY_PATTERN'"
echo "Timeout: ${TIMEOUT_SECONDS}s"
echo "=================================================="

READY_SERVICES=""

is_ready() {
  local svc="$1"
  echo "$READY_SERVICES" | grep -qw "$svc"
}

mark_ready() {
  READY_SERVICES="$READY_SERVICES $1"
}

while true; do
  ALL_READY=true

  for svc in "${CONNECT_SERVICES[@]}"; do
    if is_ready "$svc"; then
      continue
    fi

    if docker compose logs "$svc" 2>/dev/null | grep -q "$READY_PATTERN"; then
      echo "✔ $svc is ready"
      mark_ready "$svc"
    else
      ALL_READY=false
      echo "… waiting for $svc"
    fi
  done

  if [[ "$ALL_READY" == "true" ]]; then
    echo "=================================================="
    echo "All Kafka Connect workers are ready"
    echo "=================================================="
    exit 0
  fi

  NOW=$(date +%s)
  ELAPSED=$((NOW - START_TIME))

  if [[ "$ELAPSED" -ge "$TIMEOUT_SECONDS" ]]; then
    echo "=================================================="
    echo "❌ Timeout reached (${TIMEOUT_SECONDS}s)"
    echo "Connect workers not ready:"
    for svc in "${CONNECT_SERVICES[@]}"; do
      if ! is_ready "$svc"; then
        echo "  - $svc"
      fi
    done
    echo "=================================================="
    exit 1
  fi

  sleep "$SLEEP_SECONDS"
done
