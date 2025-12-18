docker compose up -d

docker exec kafka1 kafka-topics \
  --bootstrap-server kafka1:9092 \
  --create \
  --topic connect-configs \
  --replication-factor 3 \
  --partitions 1

docker exec kafka1 kafka-topics \
  --bootstrap-server kafka1:9092 \
  --create \
  --topic connect-offsets \
  --replication-factor 3 \
  --partitions 25

docker exec kafka1 kafka-topics \
  --bootstrap-server kafka1:9092 \
  --create \
  --topic connect-status \
  --replication-factor 3 \
  --partitions 5

