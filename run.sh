docker compose up -d

docker exec kafka1 kafka-topics \
  --bootstrap-server kafka1:9092 \
  --create \
  --topic connect-configs \
  --replication-factor 3 \
  --partitions 1 \
  --config min.insync.replicas=2 \
  --config cleanup.policy=compact

docker exec kafka1 kafka-topics \
  --bootstrap-server kafka1:9092 \
  --create \
  --topic connect-offsets \
  --replication-factor 3 \
  --partitions 25 \
  --config min.insync.replicas=2 \
  --config cleanup.policy=compact

docker exec kafka1 kafka-topics \
  --bootstrap-server kafka1:9092 \
  --create \
  --topic connect-status \
  --replication-factor 3 \
  --partitions 5 \
  --config min.insync.replicas=2 \
  --config cleanup.policy=compact

docker buildx build \
  --platform linux/amd64 \
  -t kafka-connect-debezium-jdbc:1.9 \
  --load \
  ./connect

docker compose --profile connect up -d

./wait-connect-ready.sh

./generate-connectors.sh

./deploy-connectors.sh

./connect-status-table.sh

./fill-src-data.sh

./check-dst-counts.sh

./stop-dc2-services.sh