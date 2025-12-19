FROM debezium/connect:1.9

USER root

# Create plugin directory for JDBC
RUN mkdir -p /kafka/connect/jdbc

# JDBC Sink Connector
RUN curl -L \
  https://packages.confluent.io/maven/io/confluent/kafka-connect-jdbc/10.2.0/kafka-connect-jdbc-10.2.0.jar \
  -o /kafka/connect/jdbc/kafka-connect-jdbc.jar

# PostgreSQL JDBC Driver
RUN curl -L \
  https://jdbc.postgresql.org/download/postgresql-42.6.0.jar \
  -o /kafka/connect/jdbc/postgresql-jdbc.jar

USER kafka
