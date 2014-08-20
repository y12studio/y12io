#!/bin/sh
cd /opt/gs-accessing-mongodb-data-rest/complete
java -jar build/libs/gs-accessing-mongodb-data-rest-0.1.0.jar \
  --spring.data.mongodb.uri=mongodb://$MONGO_PORT_27017_TCP_ADDR:$MONGO_PORT_27017_TCP_PORT/mydb