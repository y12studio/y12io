#!/bin/bash
# non block mongod startup
/usr/bin/mongod --config /etc/mongodb.conf &
until nc -z localhost 27017
do
    sleep 1
done
mongo devDB /app/mongo_adduser.js
# block loopback/nodejs startup
cd /app && node .
