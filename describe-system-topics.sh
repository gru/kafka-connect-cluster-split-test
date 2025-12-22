#!/usr/bin/env bash
set -e

# ==================================================
# Defaults (can be overridden via env vars)
# ==================================================
CONNECT_KAFKA_CONTAINER="${CONNECT_KAFKA_CONTAINER:-kafka1}"
CONNECT_BOOTSTRAP_SERVER="${CONNECT_BOOTSTRAP_SERVER:-kafka1:9092}"

echo
echo "=================================================="
echo "Topics description:"
echo "=================================================="

describe_topic () {
  local TOPIC_NAME="$1"

  echo
  echo "---- $TOPIC_NAME ----"
  docker exec "$CONNECT_KAFKA_CONTAINER" kafka-topics \
    --bootstrap-server "$CONNECT_BOOTSTRAP_SERVER" \
    --describe \
    --topic "$TOPIC_NAME"
}

# Kafka Connect internal topics
describe_topic "connect-configs"
describe_topic "connect-offsets"
describe_topic "connect-status"

# Kafka system topics
describe_topic "__consumer_offsets"
describe_topic "__transaction_states"

echo
echo "=================================================="
echo "Done."
echo "=================================================="
