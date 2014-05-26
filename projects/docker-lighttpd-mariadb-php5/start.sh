#!/bin/bash
if [ ! -f /data/mysql ]; then
    echo "=> initializing mysql tables"
    mysql_install_db > /dev/null 2>&1
    /usr/bin/mysqld_safe &
    sleep 12s
	MYSQL_PASSWORD=mysql1234
	APPDB_PASSWORD=appdb1234
	mysqladmin -u root password $MYSQL_PASSWORD 
    mysql -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE appdb; GRANT ALL PRIVILEGES ON appdb.* TO 'appdb'@'localhost' IDENTIFIED BY '$APPDB_PASSWORD'; FLUSH PRIVILEGES;"
	/install_phpmyadmin.sh > /dev/null 2>&1
	ln -s /usr/share/phpmyadmin/ /var/www
    killall mysqld
    sleep 9s
fi
echo "Start mariadb"
/usr/bin/mysqld_safe &
echo "Start php5-fpm"
service php5-fpm start
echo "Start lighttpd"
service lighttpd start
echo "Start ssh server"
/usr/sbin/sshd -D