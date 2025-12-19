FROM debezium/connect:1.9

# JDBC Sink Connector
RUN curl -L \
  https://packages.confluent.io/maven/io/confluent/kafka-connect-jdbc/10.2.0/kafka-connect-jdbc-10.2.0.jar \
  -o /kafka/connect/kafka-connect-jdbc.jar

# PostgreSQL JDBC Driver
RUN curl -L \
  https://jdbc.postgresql.org/download/postgresql-42.6.0.jar \
  -o /kafka/connect/postgresql-jdbc.jar
