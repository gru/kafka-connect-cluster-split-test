docker buildx build \
  --platform linux/amd64 \
  -t kafka-connect-debezium-jdbc:1.9 \
  --load \
  ./connect