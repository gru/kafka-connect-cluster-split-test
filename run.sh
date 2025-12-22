source .env.r4misr2

docker compose up -d

./create-connect-topics.sh

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

./fill-src-data.sh

./start-dc2-services.sh