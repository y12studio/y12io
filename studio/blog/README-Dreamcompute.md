Sun Apr 19 16:39:09 CST 2015
============================

[Using mod_spdy with PHP - Protocols — Google Developers](https://developers.google.com/speed/spdy/mod_spdy/php)

php5_module found in apache2ctl -M, wordpress:4.1.1 apache with mod_php

```
dhc-user@blog-red:~/wp$ docker-compose ps
     Name                   Command               State         Ports
----------------------------------------------------------------------------
wp_db_1          /docker-entrypoint.sh mysqld     Up      3306/tcp
wp_gcmt_1        python -m SimpleHTTPServer       Up
wp_varnish_1     /start.sh                        Up      0.0.0.0:80->80/tcp
wp_wordpress_1   /entrypoint.sh apache2-for ...   Up      80/tcp

dhc-user@blog-red:~/wp$ docker exec -i -t wp_wordpress_1 bash
root@5d9c93c3c11e:/var/www/html# apache2ctl -M
AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.17.0.4. Set the 'ServerName' directive globally to suppress this message
Loaded Modules:
 core_module (static)
 so_module (static)
 watchdog_module (static)
 http_module (static)
 log_config_module (static)
 logio_module (static)
 version_module (static)
 unixd_module (static)
 access_compat_module (shared)
 alias_module (shared)
 auth_basic_module (shared)
 authn_core_module (shared)
 authn_file_module (shared)
 authz_core_module (shared)
 authz_host_module (shared)
 authz_user_module (shared)
 autoindex_module (shared)
 deflate_module (shared)
 dir_module (shared)
 env_module (shared)
 filter_module (shared)
 mime_module (shared)
 mpm_prefork_module (shared)
 negotiation_module (shared)
 php5_module (shared)
 rewrite_module (shared)
 setenvif_module (shared)
 status_module (shared)

```

Sat Apr 18 06:16:06 UTC 2015
===========================

Adjust Apache

```

dhc-user@blog-vol:~/wp$ docker exec -i -t wp_wordpress_1 bash
root@88e04c9b3316:/var/www/html# ps aux | grep apache
root         1  0.0  0.9 173124  9832 ?        Ss   05:29   0:00 apache2 -DFOREGROUND
www-data    37  0.2  1.2 252468 13204 ?        S    05:29   0:08 apache2 -DFOREGROUND
www-data    38  0.1  3.3 272480 33980 ?        S    05:29   0:05 apache2 -DFOREGROUND
www-data    39  0.1  3.2 271752 33400 ?        S    05:29   0:04 apache2 -DFOREGROUND
www-data    40  0.2  3.0 270812 31404 ?        S    05:29   0:08 apache2 -DFOREGROUND
www-data    41  0.2  3.2 271724 33168 ?        S    05:29   0:08 apache2 -DFOREGROUND
www-data    43  0.1  3.2 271964 33372 ?        S    05:29   0:05 apache2 -DFOREGROUND
www-data    44  0.2  1.2 252464 13228 ?        S    05:29   0:08 apache2 -DFOREGROUND
www-data    51  0.1  1.4 253488 14400 ?        S    05:37   0:04 apache2 -DFOREGROUND
www-data    52  0.1  3.3 272764 34176 ?        S    05:37   0:05 apache2 -DFOREGROUND
www-data    53  0.1  3.3 272704 34272 ?        S    05:37   0:04 apache2 -DFOREGROUND


dhc-user@blog-vol:~/wp$ docker run -i -t --entrypoint=/bin/bash wordpress

root@cc9f134ffb6c:/var/www/html# grep -rnw /etc/apache2 -e "mpm_prefork_module"
/etc/apache2/mods-available/mpm_prefork.load:2:LoadModule mpm_prefork_module /usr/lib/apache2/modules/mod_mpm_prefork.so
/etc/apache2/mods-available/mpm_prefork.conf:8:<IfModule mpm_prefork_module>

root@cc9f134ffb6c:/var/www/html# grep -rnw /etc/apache2 -e "mpm_worker_module"
/etc/apache2/mods-available/mpm_worker.conf:12:<IfModule mpm_worker_module>
/etc/apache2/mods-available/mpm_worker.load:2:LoadModule mpm_worker_module /usr/lib/apache2/modules/mod_mpm_worker.so

root@cc9f134ffb6c:/var/www/html# grep -rnw /etc/apache2 -e "mpm_event_module"
/etc/apache2/mods-available/mpm_event.conf:8:<IfModule mpm_event_module>
/etc/apache2/mods-available/mpm_event.load:2:LoadModule mpm_event_module /usr/lib/apache2/modules/mod_mpm_event.so

# nano wpblue/Dockerfile and conf

dhc-user@blog-vol:~/wp$ docker-compose up -d

dhc-user@blog-vol:~/wp$ docker exec -i -t wp_wordpress_1 bash
root@d582eb294771:/var/www/html# ps aux | grep apache
root         1  0.1  0.8 173124  8876 ?        Ss   06:44   0:00 apache2 -DFOREGROUND
www-data    38  0.4  2.7 193468 28044 ?        S    06:44   0:00 apache2 -DFOREGROUND
www-data    39  1.2  1.1 177056 11892 ?        S    06:44   0:01 apache2 -DFOREGROUND

dhc-user@blog-vol:~/wp$ docker images
REPOSITORY               TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
wp_wordpress             latest              9752a9dbf914        51 minutes ago      451.5 MB
benhall/docker-varnish   latest              282eba9c2ba0        4 days ago          332 MB
y12docker/apbase         1504                09e73697260a        12 days ago         54.01 MB
wordpress                4.1.1               f90659c8fdb9        2 weeks ago         451.5 MB
wordpress                latest              f90659c8fdb9        2 weeks ago         451.5 MB
mariadb                  10.0.17             7f70676c217c        2 weeks ago         257.4 MB
mariadb                  latest              7f70676c217c        2 weeks ago         257.4 MB

```

Sat Apr 18 03:16:50 UTC 2015
============================
[How To Run WordPress on a DigitalOcean 512MB VPS - RyanFrankel.com](http://ryanfrankel.com/run-wordpress-digital-ocean-512mb-vps/)

Set up varnish caching

[Using Varnish with WordPress - RyanFrankel.com](http://ryanfrankel.com/using-varnish-with-wordpress/)

[Website speed test - pingdom ](http://tools.pingdom.com/) blog.y12.tw

before varnish : Requests= 14, Load time = 2.34s

after varnish :

Requests= 14, Load time = 1.8s

Requests= 14, Load time = 724ms

[Scaling Wordpress with Varnish and Docker - Ben Hall's blog](http://blog.benhall.me.uk/2015/01/scaling-wordpress-varnish-docker/)

```
dhc-user@blog-vol:~/wp$ docker-compose stop
Stopping wp_gcmt_1...
Stopping wp_wordpress_1...
Stopping wp_db_1...
dhc-user@blog-vol:~/wp$ docker-compose rm
Going to remove wp_gcmt_1, wp_wordpress_1, wp_db_1
Are you sure? [yN] y
Removing wp_db_1...
Removing wp_wordpress_1...
Removing wp_gcmt_1...

dhc-user@blog-vol:~/wp$ nano docker-compose.yml

wordpress:
    image: wordpress
    links:
        - db:mysql
    volumes:
        - databox/html/:/var/www/html/
    environment:
        - WORDPRESS_DB_PASSWORD=1234

db:
    image: mariadb
    volumes:
        - databox/mysql/:/var/lib/mysql/
    environment:
        - MYSQL_ROOT_PASSWORD=1234

varnish:
    image: benhall/docker-varnish
    links:
        - wordpress
    environment:
        - VIRTUAL_HOST=blog.y12.tw
        - VARNISH_BACKEND_PORT=80
        - VARNISH_BACKEND_HOST=wordpress
    ports:
        - 80:80


dhc-user@blog-vol:~/wp$ docker-compose up -d


```


Sat Apr 18 02:38:48 UTC 2015
============================

[ubermuda/docker-wordpress](https://github.com/ubermuda/docker-wordpress)

```

dhc-user@blog-vol:~/wp$ cat docker-compose.yml
wordpress:
    image: wordpress
    links:
        - db:mysql
    ports:
        - 80:80
    volumes:
        - databox/html/:/var/www/html/
    environment:
        - WORDPRESS_DB_PASSWORD=1234

db:
    image: mariadb
    volumes:
        - databox/mysql/:/var/lib/mysql/
    environment:
        - MYSQL_ROOT_PASSWORD=1234

gcmt:
    image: y12docker/apbase:1504
    links:
        - db
        - wordpress
    command: python -m SimpleHTTPServer


dhc-user@blog-vol:~/wp$ mkdir databox/html
dhc-user@blog-vol:~/wp$ mkdir databox/mysql
dhc-user@blog-vol:~/wp$ docker-compose rm
dhc-user@blog-vol:~/wp$ docker-compose up -d
dhc-user@blog-vol:~/wp$ docker-compose ps
     Name                   Command               State         Ports
----------------------------------------------------------------------------
wp_db_1          /docker-entrypoint.sh mysqld     Up      3306/tcp
wp_gcmt_1        python -m SimpleHTTPServer       Up
wp_wordpress_1   /entrypoint.sh apache2-for ...   Up      0.0.0.0:80->80/tcp

dhc-user@blog-vol:~/wp$ ls databox/html
index.php        wp-blog-header.php    wp-cron.php        wp-mail.php
license.txt      wp-comments-post.php  wp-includes        wp-settings.php
readme.html      wp-config.php         wp-links-opml.php  wp-signup.php
wp-activate.php  wp-config-sample.php  wp-load.php        wp-trackback.php
wp-admin         wp-content            wp-login.php       xmlrpc.php
dhc-user@blog-vol:~/wp$ ls databox/mysql
aria_log.00000001  ib_logfile0        mysql
aria_log_control   ib_logfile1        performance_schema
ibdata1            multi-master.info  wordpress

```


Fri Apr 17 08:47:41 UTC 2015
============================

create a instance with volume
```
dhc-user@blog-vol:~$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1       9.9G  2.5G  7.0G  26% /
none            4.0K     0  4.0K   0% /sys/fs/cgroup
udev            484M   12K  484M   1% /dev
tmpfs           100M  356K  100M   1% /run
none            5.0M     0  5.0M   0% /run/lock
none            498M     0  498M   0% /run/shm
none            100M     0  100M   0% /run/user
/dev/sr0        416K  416K     0 100% /mnt/config-2

dhc-user@blog-vol:~/wp$ docker-compose up -d
Creating wp_db_1...
Creating wp_wordpress_1...
Creating wp_gcmt_1...
dhc-user@blog-vol:~/wp$ docker-compose ps
     Name                   Command               State         Ports
----------------------------------------------------------------------------
wp_db_1          /docker-entrypoint.sh mysqld     Up      3306/tcp
wp_gcmt_1        python -m SimpleHTTPServer       Up
wp_wordpress_1   /entrypoint.sh apache2-for ...   Up      0.0.0.0:80->80/tcp

dhc-user@blog-vol:~/wp$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1       9.9G  3.6G  5.9G  38% /
none            4.0K     0  4.0K   0% /sys/fs/cgroup
udev            484M   12K  484M   1% /dev
tmpfs           100M  380K  100M   1% /run
none            5.0M     0  5.0M   0% /run/lock
none            498M  228K  497M   1% /run/shm
none            100M     0  100M   0% /run/user
/dev/sr0        416K  416K     0 100% /mnt/config-2


```




Fri Apr 17 03:40:26 UTC 2015
============================
[DreamCompute - DreamHost](http://wiki.dreamhost.com/DreamCompute)
```
dhc-user@blog:~$ swapon -s
Filename                                Type            Size    Used    Priority

dhc-user@blog:~$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1        79G  764M   75G   1% /
none            4.0K     0  4.0K   0% /sys/fs/cgroup
udev            493M   12K  493M   1% /dev
tmpfs           100M  328K  100M   1% /run
none            5.0M     0  5.0M   0% /run/lock
none            498M     0  498M   0% /run/shm
none            100M     0  100M   0% /run/user
/dev/sr0        416K  416K     0 100% /mnt/config-2

dhc-user@blog:~$ sudo apt-get update && sudo apt-get upgrade


```

[How To Add Swap on Ubuntu 14.04 | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-14-04)

```
dhc-user@blog:~$ free -m
             total       used       free     shared    buffers     cached
Mem:           994        526        467          0         41        416
-/+ buffers/cache:         69        924
Swap:            0          0          0

dhc-user@blog:~$ sudo fallocate -l 1G /swapfile
dhc-user@blog:~$ ls -lh /swapfile
-rw-r--r-- 1 root root 1.0G Apr 17 03:46 /swapfile

dhc-user@blog:~$ sudo chmod 600 /swapfile
dhc-user@blog:~$ sudo mkswap /swapfile
Setting up swapspace version 1, size = 1048572 KiB
no label, UUID=2114bf94-7e58-4631-9ba5-a86c7e0f74c6

dhc-user@blog:~$ sudo swapon /swapfile
dhc-user@blog:~$ sudo swapon -s
Filename                                Type            Size    Used    Priority
/swapfile                               file            1048572 0       -1
dhc-user@blog:~$ free -m
             total       used       free     shared    buffers     cached
Mem:           994        526        467          0         41        416
-/+ buffers/cache:         69        924
Swap:         1023          0       1023

dhc-user@blog:~$ sudo nano /etc/fstab
dhc-user@blog:~$ cat /etc/fstab
LABEL=cloudimg-rootfs   /        ext4   defaults        0 0

# Added by Cloud Image build process
/dev/sr0 /mnt/config-2 auto nobootwait,defaults,comment=configdrive 0 0
/swapfile   none    swap    sw    0   0

dhc-user@blog:~$ cat /proc/sys/vm/swappiness
60

dhc-user@blog:~$ sudo nano /etc/sysctl.conf
dhc-user@blog:~$ cat /etc/sysctl.conf | grep vm
vm.swappiness=10
vm.vfs_cache_pressure = 50

dhc-user@blog:~$ sudo reboot
```

reboot test
```
dhc-user@blog:~$ sudo swapon -s
Filename                                Type            Size    Used    Priority
/swapfile                               file            1048572 0       -1
dhc-user@blog:~$ free -m
             total       used       free     shared    buffers     cached
Mem:           994        124        869          0          9         75
-/+ buffers/cache:         39        954
Swap:         1023          0       1023
dhc-user@blog:~$ cat /proc/sys/vm/swappiness
10
dhc-user@blog:~$ cat /proc/sys/vm/vfs_cache_pressure
50

```
install docker
```
dhc-user@blog:~$ curl -sSL https://get.docker.com/ | sh
dhc-user@blog:~$ sudo usermod -aG docker dhc-user
dhc-user@blog:~$ docker -v
Docker version 1.6.0, build 4749651
dhc-user@blog:~$ docker version
Client version: 1.6.0
Client API version: 1.18
Go version (client): go1.4.2
Git commit (client): 4749651
OS/Arch (client): linux/amd64
FATA[0000] Get http:///var/run/docker.sock/v1.18/version: dial unix /var/run/docker.sock: permission denied. Are you trying to connect to a TLS-enabled daemon without TLS?

dhc-user@blog:~$ exit

Log out and log back in.

dhc-user@blog:~$ docker version
Client version: 1.6.0
Client API version: 1.18
Go version (client): go1.4.2
Git commit (client): 4749651
OS/Arch (client): linux/amd64
Server version: 1.6.0
Server API version: 1.18
Go version (server): go1.4.2
Git commit (server): 4749651
OS/Arch (server): linux/amd64

dhc-user@blog:~$ docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from hello-world
511136ea3c5a: Pull complete
31cbccb51277: Pull complete
e45a5af57b00: Already exists
Digest: sha256:55642409e2c6e441d34db2383620461a9513c54e6b7ab029faf28365ea8c6643
Status: Downloaded newer image for hello-world:latest
Hello from Docker.
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (Assuming it was not already locally available.)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

For more examples and ideas, visit:
 http://docs.docker.com/userguide/

```

install pip and docker-compose

```
dhc-user@blog:~$ curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
dhc-user@blog:~$ sudo python get-pip.py
dhc-user@blog:~$ pip -V
pip 6.1.1 from /usr/local/lib/python2.7/dist-packages (python 2.7)
dhc-user@blog:~$ sudo pip install -U docker-compose
dhc-user@blog:~$ docker-compose --version
docker-compose 1.2.0
```

install wordpress

```
dhc-user@blog:~$ mkdir wp
dhc-user@blog:~$ cd wp
dhc-user@blog:~/wp$ cat docker-compose.yml
wordpress:
    image: wordpress
    links:
        - db:mysql
    ports:
        - 8080:80
    environment:
        - WORDPRESS_DB_PASSWORD=1234
db:
    image: mariadb
    environment:
        - MYSQL_ROOT_PASSWORD=1234
gcmt:
    image: y12docker/apbase:1504
    links:
        - db
        - wordpress
    command: python -m SimpleHTTPServer

dhc-user@blog:~/wp$ docker-compose up -d
Recreating wp_db_1...
Recreating wp_wordpress_1...
Recreating wp_gcmt_1...

dhc-user@blog:~/wp$ docker-compose logs
Attaching to wp_gcmt_1, wp_wordpress_1, wp_db_1
gcmt_1      | Serving HTTP on 0.0.0.0 port 8000 ...
wordpress_1 | AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.17.0.8. Set the 'ServerName' directive globally to suppress this message
wordpress_1 | AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.17.0.8. Set the 'ServerName' directive globally to suppress this message
wordpress_1 | [Fri Apr 17 04:27:51.144372 2015] [mpm_prefork:notice] [pid 1] AH00163: Apache/2.4.10 (Debian) PHP/5.6.7 configured -- resuming normal operations
wordpress_1 | [Fri Apr 17 04:27:51.144510 2015] [core:notice] [pid 1] AH00094: Command line: 'apache2 -D FOREGROUND'
db_1        | 150417  4:27:49 [Note] InnoDB: Using mutexes to ref count buffer pool pages
db_1        | 150417  4:27:49 [Note] InnoDB: The InnoDB memory heap is disabled
db_1        | 150417  4:27:49 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
db_1        | 150417  4:27:49 [Note] InnoDB: Memory barrier is not used
db_1        | 150417  4:27:49 [Note] InnoDB: Compressed tables use zlib 1.2.7
db_1        | 150417  4:27:49 [Note] InnoDB: Using Linux native AIO
db_1        | 150417  4:27:49 [Note] InnoDB: Not using CPU crc32 instructions
db_1        | 150417  4:27:49 [Note] InnoDB: Initializing buffer pool, size = 256.0M
db_1        | 150417  4:27:49 [Note] InnoDB: Completed initialization of buffer pool
db_1        | 150417  4:27:50 [Note] InnoDB: Highest supported file format is Barracuda.
db_1        | 150417  4:27:50 [Note] InnoDB: 128 rollback segment(s) are active.
db_1        | 150417  4:27:50 [Note] InnoDB: Waiting for purge to start
db_1        | 150417  4:27:50 [Note] InnoDB:  Percona XtraDB (http://www.percona.com) 5.6.22-72.0 started; log sequence number 1616717
db_1        | 150417  4:27:50 [Note] Plugin 'FEEDBACK' is disabled.
db_1        | 150417  4:27:50 [Note] Server socket created on IP: '::'.
db_1        | 150417  4:27:50 [Note] Event Scheduler: Loaded 0 events
db_1        | 150417  4:27:50 [Note] Reading of all Master_info entries succeded
db_1        | 150417  4:27:50 [Note] Added new Master_info '' to hash table
db_1        | 150417  4:27:50 [Note] mysqld: ready for connections.
db_1        | Version: '10.0.17-MariaDB-1~wheezy-log'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  mariadb.org binary distribution
db_1        | 150417  4:27:50 [Warning] IP address '172.17.0.8' could not be resolved: Name or service not known

dhc-user@blog:~/wp$ docker-compose ps
     Name                   Command               State         Ports
----------------------------------------------------------------------------
wp_db_1          /docker-entrypoint.sh mysqld     Up      3306/tcp
wp_gcmt_1        python -m SimpleHTTPServer       Up
wp_wordpress_1   /entrypoint.sh apache2-for ...   Up      0.0.0.0:80->80/tcp

dhc-user@blog:~/wp$ curl -v http://localhost/
* Hostname was NOT found in DNS cache
*   Trying 127.0.0.1...
* Connected to localhost (127.0.0.1) port 80 (#0)
> GET / HTTP/1.1
> User-Agent: curl/7.35.0
> Host: localhost
> Accept: */*
>
< HTTP/1.1 302 Found
< Date: Fri, 17 Apr 2015 04:35:58 GMT
* Server Apache/2.4.10 (Debian) PHP/5.6.7 is not blacklisted
< Server: Apache/2.4.10 (Debian) PHP/5.6.7
< X-Powered-By: PHP/5.6.7
< Expires: Wed, 11 Jan 1984 05:00:00 GMT
< Cache-Control: no-cache, must-revalidate, max-age=0
< Pragma: no-cache
< Location: http://localhost/wp-admin/install.php
< Content-Length: 0
< Content-Type: text/html; charset=UTF-8
<
* Connection #0 to host localhost left intact


```
