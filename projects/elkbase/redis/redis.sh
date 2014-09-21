#!/bin/bash
exec /sbin/setuser redis /usr/local/bin/redis-server /etc/redis/redis.conf >> /var/log/redis-server.log 2>&1
