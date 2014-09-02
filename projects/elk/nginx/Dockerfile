FROM y12studio/elk
MAINTAINER Y12STUDIO <y12studio@gmail.com>

RUN apt-get -y update
RUN apt-get install -y nginx
ADD nginx.conf /etc/nginx/nginx.conf

ENV NGINX /etc/service/nginx/run
RUN mkdir -p "$(dirname "$NGINX")" && echo '#!/bin/bash' > $NGINX &&\
    echo '/usr/sbin/nginx' >> $NGINX && chmod +x $NGINX

ENV LFSCONF /opt/logstash-forwarder/lfs.json
ADD lfs.json $LFSCONF
# ELK_ELKX_1_PORT_8050_TCP_ADDR=172.17.0.92
# ELK_ELKX_1_PORT_8050_TCP_PORT=8050
ENV LFS /etc/service/lfs/run
RUN mkdir -p "$(dirname "$LFS")" && echo '#!/bin/bash' > $LFS &&\
    echo 'sed -i "s/localhost/$ELK_ELKX_1_PORT_8050_TCP_ADDR/g" $LFSCONF' >> $LFS &&\
    echo '/opt/logstash-forwarder/bin/logstash-forwarder -config $LFSCONF' >> $LFS &&\
	chmod +x $LFS
	
CMD ["/sbin/my_init"]
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*