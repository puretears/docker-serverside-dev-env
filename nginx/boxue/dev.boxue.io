server {
    listen 11443 ssl http2;
    server_name dev.boxue.io;

    root /var/www/boxue/current/public;

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
        fastcgi_pass app:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }

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

    ssl_certificate     /etc/nginx/ssl/dev.boxue.io.crt;
    ssl_certificate_key /etc/nginx/ssl/dev.boxue.io.key;

    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 60m;
    ssl_session_tickets on;

    ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;
    ssl_ciphers EECDH+CHACHA20:EECDH+AES128:RSA+AES128:EECDH+AES256:RSA+AES256:EECDH+3DES:RSA+3DES:!MD5;

    ssl_prefer_server_ciphers on;
    add_header Strict-Transport-Security max-age=15768000;

    resolver 8.8.8.8 8.8.4.4 valid=300s;
    resolver_timeout 5s;
}

server {
    listen 80;
    server_name dev.boxue.io;
    return 301 https://dev.boxue.io$request_uri;
}
