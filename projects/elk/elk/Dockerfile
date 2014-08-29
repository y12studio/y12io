FROM y12studio/elk
MAINTAINER Y12STUDIO <y12studio@gmail.com>

# Download latest package lists
RUN apt-get -y update

# Install dependencies
RUN apt-get install -yq openjdk-7-jre-headless

# Download version 1.4.2 of logstash
RUN cd /tmp && \
    wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz && \
    tar -xzvf ./logstash-1.4.2.tar.gz && \
    mv ./logstash-1.4.2 /opt/logstash

# Install ElasticSearch.
RUN cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.2.tar.gz && \
  tar xvzf elasticsearch-1.3.2.tar.gz && \
  mv /tmp/elasticsearch-1.3.2 /opt/elasticsearch

ADD logstash.conf /opt/logstash.conf
ADD logstash.sh /etc/service/logstash/run
RUN chmod +x /etc/service/logstash/run

ADD elasticsearch.sh /etc/service/elasticsearch/run
RUN chmod +x /etc/service/elasticsearch/run

ENV JAVA_HOME  /usr/lib/jvm/java-7-openjdk-amd64/

CMD ["/sbin/my_init"]
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*