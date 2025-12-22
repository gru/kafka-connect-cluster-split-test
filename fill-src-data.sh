#!/usr/bin/env bash
set -e

POSTGRES_SERVICE="postgres"
DB="src"
USER="postgres"

ROWS_PER_RUN=100

echo "=================================================="
echo "Filling src tables with test data"
echo "=================================================="

for i in $(seq 1 10); do
  TABLE="tbl${i}"

  echo "Inserting data into ${DB}.${TABLE}"

  docker compose  --env-file .env.rf3misr2 exec -T "$POSTGRES_SERVICE" psql \
    -U "$USER" \
    -d "$DB" \
    <<EOF
INSERT INTO ${TABLE} (name)
SELECT
  '${TABLE}_name_' || gs
FROM generate_series(1, ${ROWS_PER_RUN}) gs;
EOF

done

echo "=================================================="
echo "Done."
echo "=================================================="
