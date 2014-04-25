#!/bin/bash
# replace mongo url
sed -i "s,MY_MONGOLIB_URL,$1,g" /app/datasources.json
cat /app/datasources.json
cd /app && node .
