#!/usr/bin/env bash
set -e

CONNECT_URL="http://localhost:8083"

printf "\n%-35s | %-18s | %-30s\n" "CONNECTOR NAME" "CONNECTOR STATE" "TASK STATES"
printf "%-35s-+-%-18s-+-%-30s\n" \
  "-----------------------------------" \
  "------------------" \
  "------------------------------"

CONNECTORS=$(curl -s "$CONNECT_URL/connectors" | jq -r '.[]')

for NAME in $CONNECTORS; do
  STATUS_JSON=$(curl -s "$CONNECT_URL/connectors/$NAME/status")

  CONNECTOR_STATE=$(echo "$STATUS_JSON" | jq -r '.connector.state')

  TASK_STATES=$(echo "$STATUS_JSON" | jq -r '
    .tasks
    | map("task" + (.id|tostring) + ":" + .state)
    | join(", ")
  ')

  printf "%-35s | %-18s | %-30s\n" \
    "$NAME" \
    "$CONNECTOR_STATE" \
    "${TASK_STATES:-none}"
done

echo

