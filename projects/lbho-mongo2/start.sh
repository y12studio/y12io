#!/bin/bash
# replace mongo url
sed -i "s/127.0.0.1/$1/g" /app/datasources.json
sed -i "s/27017/$2/g" /app/datasources.json
cd /app && node .
