#!/usr/bin/env bash
set -e

# ==================================================
# Defaults (can be overridden via env vars)
# ==================================================
CONNECT_KAFKA_CONTAINER="${CONNECT_KAFKA_CONTAINER:-kafka1}"
CONNECT_BOOTSTRAP_SERVER="${CONNECT_BOOTSTRAP_SERVER:-kafka1:9092}"

CONNECT_REPLICATION_FACTOR="${CONNECT_REPLICATION_FACTOR:-3}"
CONNECT_MIN_INSYNC_REPLICAS="${CONNECT_MIN_INSYNC_REPLICAS:-2}"

echo "=================================================="
echo "Kafka Connect internal topics configuration:"
echo "  bootstrap-server        = $CONNECT_BOOTSTRAP_SERVER"
echo "  replication-factor      = $CONNECT_REPLICATION_FACTOR"
echo "  min.insync.replicas     = $CONNECT_MIN_INSYNC_REPLICAS"
echo "=================================================="
echo

create_topic () {
  local TOPIC_NAME="$1"
  local PARTITIONS="$2"

  echo "Creating topic: $TOPIC_NAME (partitions=$PARTITIONS)"

  docker exec "$CONNECT_KAFKA_CONTAINER" kafka-topics \
    --bootstrap-server "$CONNECT_BOOTSTRAP_SERVER" \
    --create \
    --if-not-exists \
    --topic "$TOPIC_NAME" \
    --replication-factor "$CONNECT_REPLICATION_FACTOR" \
    --partitions "$PARTITIONS" \
    --config "min.insync.replicas=$CONNECT_MIN_INSYNC_REPLICAS" \
    --config cleanup.policy=compact
}

# ==================================================
# Kafka Connect internal topics
# ==================================================
create_topic "connect-configs" 1
create_topic "connect-offsets" 25
create_topic "connect-status" 5

echo
echo "=================================================="
echo "Done."
echo "=================================================="
