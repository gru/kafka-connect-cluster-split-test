# Kafka Connect Cluster Split Test

Тестовый проект для проверки отказоустойчивости распределённого кластера Kafka + Kafka Connect + Debezium при выходе из строя половины узлов. Скрипты позволяют разворачивать кластер с различными конфигурациями репликации и фактором репликации, моделировать отказ половины нод в двух дата-центрах и проверять способность системы к восстановлению и продолжению синхронизации данных.

## Docker Compose

`docker-compose.yml` разворачивает распределённый кластер из двух дата-центров (DC1 и DC2) с общим ZooKeeper ансамблем:

- **Kafka**: 8 брокеров (4 в DC1: kafka1-4, 4 в DC2: kafka5-8), параметры репликации системных топиков настраиваются через переменные окружения
- **Kafka Connect**: 4 воркера (connect1-2 в DC1, connect3-4 в DC2) с Debezium и JDBC драйверами, объединённые в единый кластер через `GROUP_ID: connect-cluster`
- **PostgreSQL**: СУБД с логической репликацией (wal_level=logical) для CDC через Debezium

## Конфигурации тестов

Файлы `.env.rfXmisrY` задают параметры репликации для запуска тестов:
- `rf` — replication factor (фактор репликации)
- `misr` — min in-sync replicas (минимальное количество синхронизированных реплик)

| Файл                     | Описание                                                                                             |
|--------------------------|------------------------------------------------------------------------------------------------------|
| `.env.rf3misr2`          | RF=3, MinISR=2 — базовая конфигурация                                                                |
| `.env.rf4misr2`          | RF=4, MinISR=2                                                                                       |
| `.env.rf5misr2`          | RF=5, MinISR=2                                                                                       |
| `.env.rf6misr2`          | RF=6, MinISR=2 — максимальная репликация                                                             |
| `.env.rf4misr2_rf3misr2` | RF=4 для системных топиков Kafka, RF=3 для топиков данных (Connect), MinISR=2 — раздельные настройки |

Переменные окружения:
- `KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR` — RF для системного топика `__consumer_offsets`
- `KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR` — RF для `__transaction_state`
- `KAFKA_TRANSACTION_STATE_LOG_MIN_ISR` — MinISR для `__transaction_state`
- `KAFKA_MIN_INSYNC_REPLICAS` — MinISR по умолчанию для всех топиков
- `CONNECT_REPLICATION_FACTOR` — RF для топиков данных Connect (offsets, config, status)
- `CONNECT_MIN_INSYNC_REPLICAS` — MinISR для топиков данных Connect

