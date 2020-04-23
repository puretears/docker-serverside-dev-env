arg baseImg=boxue/base:1.0.0
FROM ${baseImg}

LABEL maintainer="Mars <11@boxue.io>"
LABEL description="PHP FPM of Boxue website and app backend."

# Install Laravel dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y \
    mysql-client \
    libpq-dev \
    libpng-dev \
    libzip-dev \
    libbz2-dev \
    libcurl4-openssl-dev \
    php-cli \
    php-common \
    php-gd \
    php-fpm \
    php-mbstring \
    php-zip \
    php-xml \
    php-sqlite3 \
    php-mysql \
    php-xdebug \
    php-curl \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install composer
RUN wget https://mirrors.aliyun.com/composer/composer.phar -O /tmp/composer.phar && \
    chmod +x /tmp/composer.phar && \
    mv /tmp/composer.phar /usr/local/bin/composer

# Delete default php-fpm config
RUN sed -i '/listen = \/run\/php\/php7\.4-fpm\.sock/d' /etc/php/7.4/fpm/pool.d/www.conf \
    && sed -i '/^;date\.timezone =/d' /etc/php/7.4/fpm/php.ini \
    && sed -i '/^;date\.timezone =/d' /etc/php/7.4/cli/php.ini \
    && sed -i '/^;display_errors = stderr/d' /etc/php/7.4/fpm/php.ini \
    && sed -i '/^memory_limit = 128M/d' /etc/php/7.4/fpm/php.ini

# The new config
RUN echo 'listen = php:9000' >> /etc/php/7.4/fpm/pool.d/www.conf \
    && echo 'date.timezone = Asia/Shanghai' >> /etc/php/7.4/fpm/php.ini \
    && echo 'date.timezone = Asia/Shanghai' >> /etc/php/7.4/cli/php.ini \
    && echo 'display_errors = stderr' >> /etc/php/7.4/fpm/php.ini \
    && echo 'memory_limit = 1024M' >> /etc/php/7.4/fpm/php.ini

# XDebug config
COPY ./xdebug.ini /etc/php/7.4/mods-available/

ENTRYPOINT ["php-fpm7.4"]
CMD ["-F"]

