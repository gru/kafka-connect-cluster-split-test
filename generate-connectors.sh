#!/usr/bin/env bash
set -e

SRC_TEMPLATE="./connectors/source-template.json"
SINK_TEMPLATE="./connectors/sink-template.json"
OUT_DIR="./connectors"

if [[ ! -f "$SRC_TEMPLATE" ]]; then
  echo "Source template not found: $SRC_TEMPLATE"
  exit 1
fi

if [[ ! -f "$SINK_TEMPLATE" ]]; then
  echo "Sink template not found: $SINK_TEMPLATE"
  exit 1
fi

echo "Generating Kafka Connect connectors..."

for i in $(seq 1 10); do
  TABLE="tbl${i}"

  SRC_OUT="${OUT_DIR}/pg-src-${TABLE}.json"
  SINK_OUT="${OUT_DIR}/jdbc-sink-${TABLE}.json"

  sed "s/{{TABLE}}/${TABLE}/g" "$SRC_TEMPLATE" > "$SRC_OUT"
  sed "s/{{TABLE}}/${TABLE}/g" "$SINK_TEMPLATE" > "$SINK_OUT"

  echo "  created:"
  echo "    - $SRC_OUT"
  echo "    - $SINK_OUT"
done

echo "Done."
