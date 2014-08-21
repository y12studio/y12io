FROM phusion/baseimage:0.9.12
MAINTAINER Y12STUDIO <y12studio@gmail.com>

ENV HOME /root
ENV LANG zh_TW.UTF-8
ENV DEBIAN_FRONTEND noninteractive
# Use UTF-8 locale inside the container
RUN locale-gen zh_TW.UTF-8
# Use the phusion baseimage's insecure key
RUN /usr/sbin/enable_insecure_key

RUN apt-get update -y 
RUN apt-get upgrade -y
# Install JDK and Gradle
RUN apt-get install -y openjdk-7-jdk gradle curl wget python git unzip

# Set Appropriate Environmental Variables
ENV JAVA_HOME /usr/lib/jvm/default-java
ENV GROOVY_HOME /usr/bin/groovy
ENV GRADLE_HOME /usr/bin/gradle
# NOTE : make sure old path first.
# old path append to new java/bin path will make my_init boot error. 
ENV PATH $PATH:$JAVA_HOME/bin:$GROOVY_HOME/bin:$GRADLE_HOME/bin

# install spring 
RUN cd /opt && git clone https://github.com/spring-guides/gs-accessing-mongodb-data-rest.git

# install protoc
# RUN apt-get install -y protobuf-compiler

#spring rest
ADD sprest.sh /etc/service/sprest/run
RUN chmod +x /etc/service/sprest/run

ENV APP_HOME /opt/gs-accessing-mongodb-data-rest/complete/

# inject new domain 
ADD src/Person.java $APP_HOME/src/main/java/hello/
ADD src/PersonRepository.java $APP_HOME/src/main/java/hello/
ADD build.gradle $APP_HOME/
RUN cd $APP_HOME && ./gradlew clean build

EXPOSE 8080
CMD ["/sbin/my_init"]
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*