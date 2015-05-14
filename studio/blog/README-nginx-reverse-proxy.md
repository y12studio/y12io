insall nginx on Dreamcompute's instance.
--------
```
$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 14.04.2 LTS
Release:        14.04
Codename:       trusty
$ add-apt-repository ppa:nginx/development
$ sudo apt-get update && sudo apt-get install nginx
$ apt-show-versions nginx
nginx:all/trusty 1.7.12-1+trusty0 uptodate
$ cat /etc/nginx/sites-available/blog.nginx
server {
    listen 80;
    server_name  blog.y12.tw;

    location / {

        proxy_pass http://10.10.10.6:80;
        proxy_set_header Host      $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}

$ sudo ln -s /etc/nginx/sites-available/blog.nginx /etc/nginx/sites-enabled/
$ sudo rm /etc/nginx/sites-enabled/default
$ cat /etc/nginx/nginx.conf | grep -E 'gzip|server_name'
        server_names_hash_bucket_size 64;
        # server_name_in_redirect off;
        gzip on;
        gzip_disable "msie6";
        # gzip_vary on;
        # gzip_proxied any;
        # gzip_comp_level 6;
        # gzip_buffers 16 8k;
        gzip_http_version 1.1;
        gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

$ sudo service nginx restart
```

insall SSL/TLS
------------

```
$ sudo mkdir /etc/nginx/ssl
$ sudo openssl req -x509 -sha256 -newkey rsa:2048 -keyout /etc/nginx/ssl/blog.y12.tw-key.pem -out /etc/nginx/ssl/blog.y12.tw-cert.pem -days 3650 -nodes

Country Name (2 letter code) [AU]:TW
State or Province Name (full name) [Some-State]:Taichung
Locality Name (eg, city) []:Taichung
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Y12Studio
Organizational Unit Name (eg, section) []:dev
Common Name (e.g. server FQDN or YOUR name) []:blog.y12.tw
Email Address []:

$ cat /etc/nginx/sites-available/blog.nginx
server {
    listen 80;
    server_name  blog.y12.tw;

    location / {
        proxy_pass http://10.10.10.6:80;
        proxy_set_header Host  $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For  $proxy_add_x_forwarded_for;
    }
}

server {
    listen 443 ssl;
    server_name  blog.y12.tw;
    ssl on;
    ssl_certificate /etc/nginx/ssl/blog.y12.tw-cert.pem;
    ssl_certificate_key /etc/nginx/ssl/blog.y12.tw-key.pem;


    location / {
        proxy_pass http://10.10.10.6:8080;
        proxy_set_header Host  $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For  $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto https;
    }
}

$ curl https://localhost/
curl: (60) SSL certificate problem: self signed certificate
More details here: http://curl.haxx.se/docs/sslcerts.html

curl performs SSL certificate verification by default, using a "bundle"
 of Certificate Authority (CA) public keys (CA certs). If the default
 bundle file isn't adequate, you can specify an alternate file
 using the --cacert option.
If this HTTPS server uses a certificate signed by a CA represented in
 the bundle, the certificate verification probably failed due to a
 problem with the certificate (it might be expired, or the name might
 not match the domain name in the URL).
If you'd like to turn off curl's verification of the certificate, use
 the -k (or --insecure) option.


```
