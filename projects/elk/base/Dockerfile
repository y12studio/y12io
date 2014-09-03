FROM phusion/baseimage:0.9.13
MAINTAINER Y12STUDIO <y12studio@gmail.com>

ENV HOME /root
ENV LANG zh_TW.UTF-8
ENV DEBIAN_FRONTEND noninteractive
# Use UTF-8 locale inside the container
RUN locale-gen zh_TW.UTF-8
# Use the phusion baseimage's insecure key
RUN /usr/sbin/enable_insecure_key

RUN apt-get -y update
RUN apt-get install -yq curl wget git golang python
RUN apt-get install -yq openjdk-7-jre-headless
RUN apt-get install -y collectd

# build logstash-forwarder
RUN mkdir -p /opt/logstash-forwarder/bin/
RUN git clone git://github.com/elasticsearch/logstash-forwarder.git /tmp/logstash-forwarder
RUN cd /tmp/logstash-forwarder && git checkout v0.3.1 && go build && \
    mv logstash-forwarder /opt/logstash-forwarder/bin/

ENV CTDCONF /opt/collectd/collectd.conf
ADD collectd.conf $CTDCONF
ENV CTD_RUN /etc/service/collectd/run
ADD collectd.sh $CTD_RUN
RUN chmod +x $CTD_RUN

CMD ["/sbin/my_init"]
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*