#!/bin/bash
ELK_IP=$LOGELK_ELK_1_PORT_9200_TCP_ADDR
if [[ -z "$ELK_IP" ]]; then
    ELK_IP=localhost
fi
sed -i "s/ELK_IP_ADDR/$ELK_IP/g" $LS_CONF
/opt/logstash/bin/logstash agent -f $LS_CONF

