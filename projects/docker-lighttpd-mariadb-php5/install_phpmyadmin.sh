#/bin/bash
# phpMyAdmin
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect lighttpd' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/dbconfig-install boolean false' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password app1234' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password mysql1234' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password app1234' | debconf-set-selections
apt-get update && apt-get -q -y install phpmyadmin