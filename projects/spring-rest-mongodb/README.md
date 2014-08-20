## install

```
git clone
$ sudo docker build -t=test/spmon .
$ sudo docker run --name monsp -d mongo
$ sudo docker run -p 8080:8080 --link monsp:mongo -d test/spmon
$ curl http://localhost:8080
$ curl http://localhost:8080/people
$ sudo docker run test/spmon java -version
java version "1.7.0_55"
OpenJDK Runtime Environment (IcedTea 2.4.7) (7u55-2.4.7-1ubuntu1)
OpenJDK 64-Bit Server VM (build 24.51-b03, mixed mode)
$ sudo docker run test/spmon gradle -version

------------------------------------------------------------
Gradle 1.4
------------------------------------------------------------

Gradle build time: 2013年9月9日 星期一 下午08時44分25秒 UTC
Groovy: 1.8.6
Ant: Apache Ant(TM) version 1.9.3 compiled on April 8 2014
Ivy: non official version
JVM: 1.7.0_55 (Oracle Corporation 24.51-b03)
OS: Linux 3.13.0-24-generic amd64


```

## ref
[Getting Started · Accessing MongoDB Data with REST](http://spring.io/guides/gs/accessing-mongodb-data-rest/)

## devlog

[mongo Repository | Docker Hub Registry - Repositories of Docker Images](https://registry.hub.docker.com/_/mongo/)

[21.?Externalized Configuration](http://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-external-config.html)

[Spring Boot and how to configure connection details to MongoDB? - Stack Overflow](http://stackoverflow.com/questions/23515295/spring-boot-and-how-to-configure-connection-details-to-mongodb)

```
sudo docker run --name monsp -d mongo
$ sudo docker build -t=test/spmon .
$ sudo docker run --rm -i -t --link monsp:mongo test/spmon /bin/bash

# env | grep MONGO
MONGO_PORT=tcp://172.17.0.21:27017
MONGO_ENV_MONGO_VERSION=2.6.4
MONGO_PORT_27017_TCP=tcp://172.17.0.21:27017
MONGO_PORT_27017_TCP_PROTO=tcp
MONGO_PORT_27017_TCP_ADDR=172.17.0.21
MONGO_NAME=/clever_tesla/mongo
MONGO_PORT_27017_TCP_PORT=27017

cd /opt 
git clone https://github.com/spring-guides/gs-accessing-mongodb-data-rest.git
cd gs-accessing-mongodb-data-rest/complete
./gradlew build
# spring.data.mongodb.uri=mongodb://localhost:27017/mydb

# java -jar build/libs/gs-accessing-mongodb-data-rest-0.1.0.jar \
  --spring.data.mongodb.uri=mongodb://$MONGO_PORT_27017_TCP_ADDR:$MONGO_PORT_27017_TCP_PORT/mydb &
# curl http://localhost:8080/
{
  "_links" : {
    "people" : {
      "href" : "http://localhost:8080/people{?page,size,sort}",
      "templated" : true
    }
  }
}
# curl http://loclhost:8080/people
{
  "_links" : {
    "self" : {
      "href" : "http://localhost:8080/people{?page,size,sort}",
      "templated" : true
    },
    "search" : {
      "href" : "http://localhost:8080/people/search"
    }
  },
  "page" : {
    "size" : 20,
    "totalElements" : 0,
    "totalPages" : 0,
    "number" : 0
  }
}

# curl -i -X POST -H "Content-Type:application/json" -d '{  "firstName" : "Frodo",  "lastName" : "Baggins" }' http://localhost:8080/people
HTTP/1.1 201 Created
Server: Apache-Coyote/1.1
Location: http://localhost:8080/people/53f48fb3e4b0df3680f10bd4
Content-Length: 0
Date: Wed, 20 Aug 2014 12:08:19 GMT

# curl http://loclhost:8080/people
{
  "_links" : {
    "self" : {
      "href" : "http://localhost:8080/people{?page,size,sort}",
      "templated" : true
    },
    "search" : {
      "href" : "http://localhost:8080/people/search"
    }
  },
  "_embedded" : {
    "people" : [ {
      "firstName" : "Frodo",
      "lastName" : "Baggins",
      "_links" : {
        "self" : {
          "href" : "http://localhost:8080/people/53f48fb3e4b0df3680f10bd4"
        }
      }
    } ]
  },
  "page" : {
    "size" : 20,
    "totalElements" : 1,
    "totalPages" : 1,
    "number" : 0
  }
}
 
```