FROM ubuntu:18.04

LABEL maintainer="Mars <11@boxue.io>"
LABEL description="Docker container for server side development"

ARG appName=dev.boxue.io
ARG appRootDir=boxue

RUN echo "Building Nginx for ${appName}"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y nginx iputils-ping vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
        && mkdir -p /etc/nginx/ssl

#ADD apn/apn.boxue.io /etc/nginx/sites-available/apn.boxue.io
#COPY apn/apn.boxue.io* /etc/nginx/ssl/
#ADD boxue/dev.boxue.io /etc/nginx/sites-available/dev.boxue.io
#COPY boxue/dev.boxue.io* /etc/nginx/ssl/

ADD ${appRootDir}/${appName} /etc/nginx/sites-available/${appName}
COPY ${appRootDir}/${appName}* /etc/nginx/ssl/

RUN ln -sf /etc/nginx/sites-available/${appName} /etc/nginx/sites-enabled/${appName} && \
    #ln -sf /etc/nginx/sites-available/dev.boxue.io /etc/nginx/sites-enabled/dev.boxue.io && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    mkdir -p /var/www/${appRootDir}/current && \
    chown www-data:www-data /var/www/${appRootDir}/current
    #mkdir -p /var/www/push-notifications/current && \
    #chown www-data:www-data /var/www/push-notifications/current && \
    #mkdir -p /var/www/boxue/current && \
    #chown www-data:www-data /var/www/boxue/current

CMD ["nginx"]

