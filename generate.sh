#!/usr/bin/env bash
set -e

TEMPLATE="./connectors/template.json"
OUT_DIR="./connectors"

if [[ ! -f "$TEMPLATE" ]]; then
  echo "Template not found: $TEMPLATE"
  exit 1
fi

echo "Generating Debezium connectors..."

for i in $(seq 1 10); do
  TABLE="tbl${i}"
  OUT_FILE="${OUT_DIR}/pg-src-${TABLE}.json"

  sed "s/{{TABLE}}/${TABLE}/g" "$TEMPLATE" > "$OUT_FILE"

  echo "  created $OUT_FILE"
done

echo "Done."

