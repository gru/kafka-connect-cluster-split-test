source .env.rf4misr2

docker compose up -d

./create-connect-topics.sh

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