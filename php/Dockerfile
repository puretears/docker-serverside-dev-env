ARG baseImg
FROM $baseImg

LABEL maintainer="Mars <11@boxue.io>"
LABEL description="PHP FPM of Boxue website and app backend."

# Install Laravel dependencies
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update &&\
    apt-get install -y software-properties-common &&\
    add-apt-repository ppa:ondrej/php &&\
    apt-get update && \
    apt-get install -y \
    mysql-client \
    libpq-dev \
    libpng-dev \
    libzip-dev \
    libbz2-dev \
    libcurl4-openssl-dev \
    php8.0-common \
    php8.0-cli \
    php8.0-gd \
    php8.0-fpm \
    php8.0-mbstring \
    php8.0-zip \
    php8.0-xml \
    php8.0-sqlite3 \
    php8.0-mysql \
    php8.0-xdebug \
    php8.0-curl \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install composer
RUN wget https://mirrors.aliyun.com/composer/composer.phar -O /tmp/composer.phar && \
    chmod +x /tmp/composer.phar && \
    mv /tmp/composer.phar /usr/local/bin/composer

# Delete default php-fpm config
RUN sed -i '/listen = \/run\/php\/php8\.0-fpm\.sock/d' /etc/php/8.0/fpm/pool.d/www.conf \
    && sed -i '/^;date\.timezone =/d' /etc/php/8.0/fpm/php.ini \
    && sed -i '/^;date\.timezone =/d' /etc/php/8.0/cli/php.ini \
    && sed -i '/^;display_errors = stderr/d' /etc/php/8.0/fpm/php.ini \
    && sed -i '/^memory_limit = 128M/d' /etc/php/8.0/fpm/php.ini

# The new config
RUN echo 'listen = php:9000' >> /etc/php/8.0/fpm/pool.d/www.conf \
    && echo 'date.timezone = Asia/Shanghai' >> /etc/php/8.0/fpm/php.ini \
    && echo 'date.timezone = Asia/Shanghai' >> /etc/php/8.0/cli/php.ini \
    && echo 'display_errors = stderr' >> /etc/php/8.0/fpm/php.ini \
    && echo 'memory_limit = 1024M' >> /etc/php/8.0/fpm/php.ini

# XDebug config
COPY ./xdebug.ini /etc/php/8.0/mods-available/

ENTRYPOINT service php8.0-fpm start && /bin/bash
#CMD ["php-fpm8.0", "-F"]

#CMD ["php", "-v"]

