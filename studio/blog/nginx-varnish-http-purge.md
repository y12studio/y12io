publish to wp-admin/post.php then blocking

[WordPress › Varnish HTTP Purge « WordPress Plugins](https://wordpress.org/plugins/varnish-http-purge/faq/)

```

nano wp-config.php
define('VHP_VARNISH_IP','varnish-link-from-docker');

$ cat docker-compose.yml
wordpress:
    build: wpblue
    links:
        - db:mysql
        - varnish
    volumes:
        - databox/html/:/var/www/html/
    environment:
        - WORDPRESS_DB_PASSWORD=abcd1234
    ports:
        - 8080:80
varnish:
    image: benhall/docker-varnish
    links:
        - wordpress
    environment:
        - VARNISH_BACKEND_PORT=80
        - VARNISH_BACKEND_HOST=wordpress
    ports:
        - 80:80

db:
    image: mariadb:10.0.17
    volumes:
        - databox/mysql/:/var/lib/mysql/
    environment:
        - MYSQL_ROOT_PASSWORD=abcd1234


dhc-user@blog150424:~/wp$ docker-compose up -d
Circular import between wordpress and varnish and db

```
