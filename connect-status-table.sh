#!/usr/bin/env bash
set -e

CONNECT_URL="http://localhost:8084"

printf "\n%-30s | %-15s | %-20s | %-35s\n" \
  "CONNECTOR NAME" "STATE" "CONNECTOR NODE" "TASKS (STATE@NODE)"

printf "%-30s-+-%-15s-+-%-20s-+-%-35s\n" \
  "------------------------------" \
  "---------------" \
  "--------------------" \
  "-----------------------------------"

CONNECTORS=$(curl -s "$CONNECT_URL/connectors" | jq -r '.[]')

for NAME in $CONNECTORS; do
  STATUS_JSON=$(curl -s "$CONNECT_URL/connectors/$NAME/status")

  CONNECTOR_STATE=$(echo "$STATUS_JSON" | jq -r '.connector.state')
  CONNECTOR_NODE=$(echo "$STATUS_JSON" | jq -r '.connector.worker_id')

  TASK_INFO=$(echo "$STATUS_JSON" | jq -r '
    if (.tasks | length) == 0 then
      "none"
    else
      .tasks
      | map("task" + (.id|tostring) + ":" + .state + "@" + .worker_id)
      | join(", ")
    end
  ')

  printf "%-30s | %-15s | %-20s | %-35s\n" \
    "$NAME" \
    "$CONNECTOR_STATE" \
    "$CONNECTOR_NODE" \
    "$TASK_INFO"
done

echo
