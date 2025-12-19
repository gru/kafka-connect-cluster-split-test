#!/usr/bin/env bash
set -e

KAFKA_CONTAINER="kafka1"
BOOTSTRAP_SERVER="kafka1:9092"
CONNECT_URL="http://localhost:8083"

echo "=================================================="
echo "Step 1: Creating Kafka topics for Debezium data"
echo "=================================================="

for f in ./connectors/pg-src-tbl*.json; do
  # Из JSON достаём имя таблицы (public.tblX)
  TABLE=$(jq -r '.config["table.include.list"]' "$f")
  TOPIC="src.${TABLE}"

  echo "Creating topic: $TOPIC"

  docker exec "$KAFKA_CONTAINER" kafka-topics \
    --bootstrap-server "$BOOTSTRAP_SERVER" \
    --create \
    --if-not-exists \
    --topic "$TOPIC" \
    --partitions 3 \
    --replication-factor 3 \
    --config min.insync.replicas=2 \
    --config cleanup.policy=compact
done

echo
echo "=================================================="
echo "Step 2: Deploying Kafka Connect connectors"
echo "=================================================="

for f in ./connectors/pg-src-tbl*.json; do
  NAME=$(jq -r '.name' "$f")

  echo "--------------------------------------------------"
  echo "Deploying connector: $NAME"

  RESPONSE=$(curl -s -w "\n%{http_code}" \
    -X POST "$CONNECT_URL/connectors" \
    -H "Content-Type: application/json" \
    -d @"$f")

  BODY=$(echo "$RESPONSE" | sed '$d')
  CODE=$(echo "$RESPONSE" | tail -n1)

  echo "HTTP status: $CODE"

  if [[ "$CODE" == "201" ]]; then
    echo "✔ Created successfully"
  elif [[ "$CODE" == "409" ]]; then
    echo "⚠ Already exists"
  else
    echo "❌ Error while creating connector"
    echo "$BODY" | jq .
  fi
done

echo
echo "=================================================="
echo "Done."
echo "=================================================="
