#!/usr/bin/env bash
set -e

CONTAINERS=(
  kafka5
  kafka6
  kafka7
  kafka8
  connect3
  connect4
)

echo "Starting containers: ${CONTAINERS[*]}"

for c in "${CONTAINERS[@]}"; do
  if docker ps -a -q -f name="^${c}$" >/dev/null; then
      docker start "$c"
  else
    echo "⚠ Container $c does not exist"
  fi
done

echo "Done."
