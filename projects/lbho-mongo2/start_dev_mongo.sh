#!/bin/bash
sudo docker.io run -d -p 27017:27017 robinvdvleuten/mongo
sleep 3
until nc -z localhost 27017
do
    sleep 1
done
sleep 3
mongo devDB mongo_adduser.js
# block loopback/nodejs startup
/usr/bin/npm install
echo "==== Note ===="
echo "== docker.io ps and docker.io stop cid =="
echo "=============="
sleep 1
/usr/bin/nodejs .
