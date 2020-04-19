server {
    listen 443 ssl http2 default_server;
    server_name apn.boxue.io;

    root /var/www/push-notifications/current/public;

    index index.html index.htm index.php;
    charset utf-8;

    add_header X-Frame-Options deny;
    add_header X-XSS-Protection "1; mode=block";
    add_header X-Content-Type-Options "nosniff";

    location / {
        try_files $uri $uri/ /index.php$is_args$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    error_page 404 /index.php;

    location ~ \.php$ {
        fastcgi_pass php:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }

    ssl_protocols TLSv1.2 TLSv1.1;
    ssl_certificate     /etc/nginx/ssl/apn.boxue.io.crt;
    ssl_certificate_key /etc/nginx/ssl/apn.boxue.io.key;

    location /socket.io {
        access_log /tmp/srv_socket.log;
        proxy_pass http://echo:6001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}

server {
    listen 80;
    server_name apn.boxue.io;
    return 301 https://apn.boxue.io$request_uri;
}
