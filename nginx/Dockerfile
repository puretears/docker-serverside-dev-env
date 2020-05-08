ARG baseImg
FROM $baseImg

ARG appName
ARG appRootDir

LABEL maintainer="Mars <11@boxue.io>"
LABEL description="Nginx server of Boxue website and app backend."

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y nginx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD $appRootDir/$appName /etc/nginx/sites-available/$appName
COPY $appRootDir/$appName.* /etc/nginx/ssl/

RUN ln -sf /etc/nginx/sites-available/$appName /etc/nginx/sites-enabled/$appName && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

RUN mkdir -p /var/www/$appRootDir/current && \
    chown www-data:www-data /var/www/$appRootDir/current

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]

