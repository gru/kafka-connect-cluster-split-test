#!/usr/bin/env bash

set -e

CONTAINERS=(
  connect1
  connect2
  kafka1
  kafka2
  kafka3
  kafka4
)

echo "Stopping containers: ${CONTAINERS[*]}"

for c in "${CONTAINERS[@]}"; do
  if docker ps -q -f name="^${c}$" >/dev/null; then
    echo "Stopping $c..."
    docker stop "$c"
  else
    echo "$c is not running"
  fi
done

echo "Done."
