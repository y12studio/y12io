FROM y12elk/base
MAINTAINER Y12STUDIO <y12studio@gmail.com>

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r elk && useradd -r -g elk elk

RUN apt-get -y update
# Install dependencies
RUN apt-get install -yq openjdk-7-jre-headless
#
# Install ElasticSearch.
#
RUN wget -qO- https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.2.tar.gz | tar xvz -C /tmp &&\
    mv /tmp/elasticsearch-* /opt/elasticsearch

ENV ES_RUN /etc/service/elasticsearch/run
RUN mkdir -p "$(dirname "$ES_RUN")" && echo '#!/bin/bash' > $ES_RUN &&\
    echo '/opt/elasticsearch/bin/elasticsearch' >> $ES_RUN && chmod +x $ES_RUN
#
# Install kibana
#
RUN wget -qO- https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz | tar xvz -C /tmp &&\
    mv /tmp/kibana-* /opt/kibana
#
# Install nginx
#
RUN apt-get install -yq nginx
ENV NGINX_RUN /etc/service/nginx/run
RUN mkdir -p "$(dirname "$NGINX_RUN")" && echo '#!/bin/bash' > $NGINX_RUN &&\
    echo '/usr/sbin/nginx' >> $NGINX_RUN && chmod +x $NGINX_RUN
ADD nginx.conf /etc/nginx/nginx.conf

#
# update kibana default route schema json file
#
# RUN cd /opt/kibana/app/dashboards && cp default.json default.json.bak
# ADD kibana.json /opt/kibana/app/dashboards/default.json

#
# logstash conf
#
ADD logstash.conf $LS_CONF
ADD nginx.pattern /opt/logstash/patterns/nginx

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD ["/sbin/my_init"]
USER elk