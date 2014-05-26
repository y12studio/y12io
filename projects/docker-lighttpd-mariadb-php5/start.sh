#!/bin/bash
if [ ! -f /data/mysql ]; then
    echo "=> initializing mysql tables"
	chown -R mysql:mysql /data/
    mysql_install_db > /dev/null 2>&1
	#mysql has to be started this way as it doesn't work to call from /etc/init.d
    /usr/bin/mysqld_safe &
    sleep 9s
	MYSQL_PASSWORD=mysql1234
	APPDB_PASSWORD=appdb1234
	mysqladmin -u root password $MYSQL_PASSWORD 
    mysql -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE appdb; GRANT ALL PRIVILEGES ON appdb.* TO 'appdb'@'localhost' IDENTIFIED BY '$APPDB_PASSWORD'; FLUSH PRIVILEGES;"
    killall mysqld
    sleep 9s
fi
/usr/bin/mysqld_safe &
service php5-fpm start
service ssh start
lighttpd -D -f /etc/lighttpd/lighttpd.conf