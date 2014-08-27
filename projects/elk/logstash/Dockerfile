FROM phusion/baseimage:0.9.12
MAINTAINER Y12STUDIO <y12studio@gmail.com>

ENV HOME /root
ENV LANG zh_TW.UTF-8
ENV DEBIAN_FRONTEND noninteractive
# Use UTF-8 locale inside the container
RUN locale-gen zh_TW.UTF-8
# Use the phusion baseimage's insecure key
RUN /usr/sbin/enable_insecure_key

# Download latest package lists
RUN apt-get update

# Install dependencies
RUN apt-get install -yq openjdk-7-jre-headless wget curl

# Download version 1.4.2 of logstash
RUN cd /tmp && \
    wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz && \
    tar -xzvf ./logstash-1.4.2.tar.gz && \
    mv ./logstash-1.4.2 /opt/logstash

ADD logstash.conf /opt/logstash.conf
ADD logstash.sh /etc/service/logstash/run
RUN chmod +x /etc/service/logstash/run
# Syslog
EXPOSE 514
CMD ["/sbin/my_init"]
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*