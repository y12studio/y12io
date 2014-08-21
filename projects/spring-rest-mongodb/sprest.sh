#!/bin/sh
cd /opt/sprest/build/libs
java -jar sprest-0.1.0.jar \
  --spring.data.mongodb.uri=mongodb://$DB_1_PORT_27017_TCP_ADDR:$DB_1_PORT_27017_TCP_PORT/mydb