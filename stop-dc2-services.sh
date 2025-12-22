#!/usr/bin/env bash

set -e

CONTAINERS=(
  connect4
  connect3
  kafka5
  kafka6
  kafka7
  kafka8
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
