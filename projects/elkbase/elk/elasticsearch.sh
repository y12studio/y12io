#!/bin/bash
exec /sbin/setuser elk /opt/elasticsearch/bin/elasticsearch >>/var/log/elasticsearch-server.log 2>&1
