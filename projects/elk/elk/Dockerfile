FROM y12studio/elk
MAINTAINER Y12STUDIO <y12studio@gmail.com>

# Download latest package lists
RUN apt-get -y update

# Install dependencies
RUN apt-get install -yq openjdk-7-jre-headless

# Download version 1.4.2 of logstash
RUN wget -qO- https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz | tar xvz -C /tmp && \
    mv /tmp/logstash-* /opt/logstash

# Install ElasticSearch.
RUN wget -qO- https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.2.tar.gz | tar xvz -C /tmp &&\
    mv /tmp/elasticsearch-* /opt/elasticsearch

# Install kibana
RUN wget -qO- https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz | tar xvz -C /tmp &&\
    mv /tmp/kibana-* /opt/kibana

# Install nginx
RUN apt-get install -yq nginx
ENV NGINX_RUN /etc/service/nginx/run
RUN mkdir -p "$(dirname "$NGINX_RUN")" && echo '#!/bin/bash' > $NGINX_RUN &&\
    echo '/usr/sbin/nginx' >> $NGINX_RUN && chmod +x $NGINX_RUN
ADD nginx.conf /etc/nginx/nginx.conf

ADD logstash.conf /opt/logstash.conf
ENV LS_RUN /etc/service/logstash/run
RUN mkdir -p "$(dirname "$LS_RUN")" && echo '#!/bin/bash' > $LS_RUN &&\
    echo '/opt/logstash/bin/logstash agent -f /opt/logstash.conf' >> $LS_RUN && chmod +x $LS_RUN

ENV ES_RUN /etc/service/elasticsearch/run
RUN mkdir -p "$(dirname "$ES_RUN")" && echo '#!/bin/bash' > $ES_RUN &&\
    echo '/opt/elasticsearch/bin/elasticsearch' >> $ES_RUN && chmod +x $ES_RUN

ADD nginx.pattern /opt/logstash/patterns/nginx

ENV JAVA_HOME  /usr/lib/jvm/java-7-openjdk-amd64/

CMD ["/sbin/my_init"]
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*