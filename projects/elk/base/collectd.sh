#!/bin/bash
sed -i "s/localhost/$HOSTNAME/g" $CTDCONF
if [[ -z "$ELK_ELKX_1_PORT_8050_TCP_ADDR" ]]; then
    ELK_ELKX_1_PORT_8050_TCP_ADDR=localhost
fi
sed -i "s/10.0.0.1/$ELK_ELKX_1_PORT_8050_TCP_ADDR/g" $CTDCONF
collectd -C $CTDCONF -f