#!/bin/bash
ELK_IP=$ELK_1_PORT_9200_TCP_ADDR
sed -i "s/localhost/$HOSTNAME/g" $CTDCONF
if [[ -z "$ELK_IP" ]]; then
    ELK_IP=localhost
fi
sed -i "s/10.0.0.1/$ELK_IP/g" $CTDCONF
collectd -C $CTDCONF -f