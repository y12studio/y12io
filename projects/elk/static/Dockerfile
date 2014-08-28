FROM phusion/baseimage:0.9.12
MAINTAINER Y12STUDIO <y12studio@gmail.com>

ENV HOME /root
ENV LANG zh_TW.UTF-8
ENV DEBIAN_FRONTEND noninteractive
# Use UTF-8 locale inside the container
RUN locale-gen zh_TW.UTF-8
# Use the phusion baseimage's insecure key
RUN /usr/sbin/enable_insecure_key

RUN apt-get -y update
RUN apt-get install -y curl wget openssl

ADD init.sh /etc/my_init.d/static.sh
RUN chmod +x /etc/my_init.d/static.sh

RUN mkdir -p /opt/static/pki/tls/certs && mkdir /opt/static/pki/tls/private
# or move to /etc/my_init.d/static.sh
RUN cd /opt/static/pki/tls && openssl req -x509 -batch -nodes -days 3650 -newkey rsa:2048 \
   -keyout private/logstash-forwarder.key -out certs/logstash-forwarder.crt
CMD ["/sbin/my_init"]
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*