FROM phusion/baseimage:0.9.13
MAINTAINER Y12STUDIO <y12studio@gmail.com>

RUN locale-gen --no-purge en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN update-locale
ENV DEBIAN_FRONTEND noninteractive

# Use the phusion baseimage's insecure key
RUN /usr/sbin/enable_insecure_key

RUN apt-get -yq update
RUN apt-get -yq upgrade
RUN apt-get install -yq curl wget git python
RUN apt-get install -yq openjdk-7-jre-headless

ENV JAVA_HOME  /usr/lib/jvm/java-7-openjdk-amd64/

#
# collectd install
#
RUN apt-get install -y collectd
ENV CTDCONF /opt/collectd/collectd.conf
ENV CTD_RUN /etc/service/collectd/run
#
# logstash install
#
# Download version 1.4.2 of logstash
RUN wget -qO- https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz | tar xvz -C /tmp && \
    mv /tmp/logstash-* /opt/logstash
ENV LS_CONF /opt/logstash.conf
ENV LS_RUN /etc/service/logstash/run
#
# conf inject
#
ADD collectd.conf $CTDCONF
ADD collectd.sh $CTD_RUN
RUN chmod +x $CTD_RUN

ADD logstash.sh $LS_RUN
RUN chmod +x $LS_RUN

ADD run.sh.tpl /opt/run.sh.tpl

CMD ["/sbin/my_init"]
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*