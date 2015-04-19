Sun Apr 19 18:27:17 CST 2015
=============================
[PHP-FPM + nginx version · Issue #54 · docker-library/php](https://github.com/docker-library/php/issues/54)

[Demonstration Docker config for Wordpress on PHP-FPM behind Nginx](https://gist.github.com/md5/d9206eacb5a0ff5d6be0)

```
~/git/y12io/studio/blog/wpfpm$ docker-compose up -d
Recreating wpfpm_db_1...
Recreating wpfpm_wordpress_1...
Recreating wpfpm_nginx_1...
Recreating wpfpm_varnish_1...

~/git/y12io/studio/blog/wpfpm$ docker-compose ps
      Name             Command             State              Ports
-------------------------------------------------------------------------
wpfpm_db_1         /docker-           Up                 3306/tcp
                   entrypoint.sh
                   mysqld
wpfpm_nginx_1      nginx -g daemon    Up                 443/tcp, 80/tcp
                   off;
wpfpm_varnish_1    /start.sh          Up                 0.0.0.0:8080->80
                                                         /tcp
wpfpm_wordpress_   /entrypoint.sh     Up                 9000/tcp
1                  php-fpm

:~/git/y12io/studio/blog/wpfpm$ docker run nginx:1.7.11 nginx -V
nginx version: nginx/1.7.11
built by gcc 4.7.2 (Debian 4.7.2-5)
TLS SNI support enabled
configure arguments: --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-http_ssl_module --with-http_realip_module --with-http_addition_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_stub_status_module --with-http_auth_request_module --with-mail --with-mail_ssl_module --with-file-aio --with-http_spdy_module --with-cc-opt='-g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed' --with-ipv6

~/git/y12io/studio/blog/wpfpm$ docker run nginx:1.7.11 openssl version
OpenSSL 1.0.1e 11 Feb 2013


```
