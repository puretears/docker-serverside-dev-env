FROM ubuntu:22.04

LABEL maintainer="Mars <11@boxue.io>"
LABEL description="Application image based on PHP."

ARG WWWUSER
ARG WWWGROUP
ARG APP_NAME

# We don't want to persist DEBIAN_FRONTEND to the containers based on this image.
# So we use ARG instead of ENV.
ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Asia/Shanghai
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime

# Install Laravel dependencies
RUN apt-get update \
    && apt-get install -y gnupg gosu curl ca-certificates zip unzip git \
        supervisor sqlite3 libcap2-bin libpng-dev python2 net-tools \
        iputils-ping

RUN apt-get update \
    && apt-get install -y php-cli php-fpm php-dev \
       php-pgsql php-sqlite3 php-gd \
       php-curl php-memcached \
       php-imap php-mysql php-mbstring \
       php-xml php-zip php-bcmath php-soap \
       php-intl php-readline \
       php-msgpack php-igbinary php-ldap \
       php-redis mysql-client
       
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');" \
    && curl -fsSL https://deb.nodesource.com/setup_18.x  \
    && apt-get install -y nodejs npm \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN groupadd --force -g $WWWGROUP fly
RUN useradd -ms /bin/bash --no-user-group -g ${WWWGROUP} -u ${WWWUSER} fly

COPY php.ini /etc/php/8.1/fpm/conf.d/99-fly.ini
COPY www.conf /etc/php/8.1/fpm/pool.d/z-fly.conf

RUN touch /var/log/php-fpm.log \
    && chown fly /var/log/php-fpm.log \
    && chown fly /run/php

WORKDIR "/var/www/${APP_NAME}/current"

CMD ["php-fpm8.1", "-F"]
