#!/bin/bash
cd /opt/topeka
python -m SimpleHTTPServer 8080 >>/var/log/topeka.log 2>&1