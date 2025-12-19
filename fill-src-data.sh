#!/usr/bin/env bash
set -e

POSTGRES_SERVICE="postgres"
DB="src"
USER="postgres"

echo "=================================================="
echo "Filling src tables with test data"
echo "=================================================="

for i in $(seq 1 10); do
  TABLE="tbl${i}"

  echo "Inserting data into ${DB}.${TABLE}"

  docker compose exec -T "$POSTGRES_SERVICE" psql \
    -U "$USER" \
    -d "$DB" \
    <<EOF
INSERT INTO ${TABLE} (id, name)
SELECT
  gs AS id,
  '${TABLE}_name_' || gs AS name
FROM generate_series(1, 100) gs
ON CONFLICT (id) DO NOTHING;
EOF

done

echo "=================================================="
echo "Done."
echo "=================================================="
