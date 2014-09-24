FROM y12docker/redis

ADD logstash.conf $LS_CONF
ADD logstash.sh $LS_SRV
RUN chmod +x $LS_SRV

ADD collectd.conf $CTD_CONF
ADD collectd.sh $CTD_SRV
RUN chmod +x $CTD_SRV

CMD ["/sbin/my_init"]