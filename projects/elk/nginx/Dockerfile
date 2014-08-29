FROM y12studio/elk
MAINTAINER Y12STUDIO <y12studio@gmail.com>

RUN apt-get -y update
RUN apt-get install -y nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

ADD nginx.sh /etc/service/nginx/run
RUN chmod +x /etc/service/nginx/run

ADD lfs.json /opt/logstash-forwarder/lfs.json
#ADD lfs.sh /etc/service/lfs/run
#RUN chmod +x /etc/service/lfs/run

EXPOSE 80
CMD ["/sbin/my_init"]
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*