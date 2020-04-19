FROM boxue/php:0.1.0

LABEL maintainer="Mars <11@boxue.io>"
LABEL description="Docker container for server side development."

# Install Laravel dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y gnupg2 vim

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN npm install -g laravel-echo-server
COPY ./laravel-echo-server.json /root

ENTRYPOINT ["laravel-echo-server"]
CMD ["start", "--force", "--dir=/root"]

