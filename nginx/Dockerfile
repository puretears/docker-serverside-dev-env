FROM ubuntu:21.10

LABEL maintainer="Mars <11@boxue.io>"
LABEL description="Nginx server of the application."

ARG WWWUSER
ARG WWWGROUP
ARG APP_NAME
ARG NGINX_CONF

# Install Laravel dependencies
RUN apt-get update && apt-get install -y nginx

COPY ${APP_NAME}/${NGINX_CONF} /etc/nginx/sites-available/${NGINX_CONF}
COPY ${APP_NAME}/${NGINX_CONF}.* /etc/nginx/ssl/

RUN groupadd --force -g $WWWGROUP fly
RUN useradd -ms /bin/bash --no-user-group -g ${WWWGROUP} -u ${WWWUSER} fly

RUN sed -i 's/user www-data/user fly/' /etc/nginx/nginx.conf \
    && sed -i 's/worker_processes auto/worker_processes 4/' /etc/nginx/nginx.conf

RUN mkdir -p /var/www/${APP_NAME}/current \
    && chown ${WWWUSER}:${WWWGROUP} /var/www/${APP_NAME}/current \
    && chown ${WWWUSER} /var/log/nginx/* \
    && chown ${WWWUSER} -R /etc/nginx \
    && ln -sf /etc/nginx/sites-available/${NGINX_CONF} /etc/nginx/sites-enabled/${NGINX_CONF}

WORKDIR /var/www/${APP_NAME}/current

CMD ["nginx", "-g", "daemon off;"]
