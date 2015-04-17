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
        - WORDPRESS_DB_PASSWORD=dPY1WddGr
db:
    image: mariadb
    environment:
        - MYSQL_ROOT_PASSWORD=dPY1WddGr
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