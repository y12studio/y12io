#!/bin/bash
exec /sbin/setuser SRV_USER SRV_CMD >>/var/log/SRV_LOG.log 2>&1
