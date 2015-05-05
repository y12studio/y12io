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
