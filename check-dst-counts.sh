#!/usr/bin/env bash
set -e

POSTGRES_SERVICE="postgres"
DB="dst"
USER="postgres"

echo "=================================================="
echo "Row counts in dst database"
echo "=================================================="

for i in $(seq 1 10); do
  TABLE="tbl${i}"

  COUNT=$(docker compose exec -T "$POSTGRES_SERVICE" psql \
    -U "$USER" \
    -d "$DB" \
    -t -c "SELECT COUNT(*) FROM ${TABLE};" \
    | xargs)

  printf "%-10s : %s rows\n" "${TABLE}" "${COUNT}"
done

echo "=================================================="
echo "Done."
echo "=================================================="
