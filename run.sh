docker compose up -d

CONNECT_REPLICATION_FACTOR=3 \
CONNECT_MIN_INSYNC_REPLICAS=2 \
./create-connect-topics.sh

docker buildx build \
  --platform linux/amd64 \
  -t kafka-connect-debezium-jdbc:1.9 \
  --load \
  ./connect

docker compose --profile connect up -d

./wait-connect-ready.sh

./generate-connectors.sh

PARTITIONS=3 \
REPLICATION_FACTOR=3 \
MIN_INSYNC_REPLICAS=2 \
./deploy-connectors.sh

./connect-status-table.sh

./fill-src-data.sh

./check-dst-counts.sh

./stop-dc2-services.sh