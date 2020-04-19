FROM boxue/php:0.1.0

LABEL maintainer="Mars <11@boxue.io>"
LABEL description="Docker container for server side development."

# Install Laravel dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y redis \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ENTRYPOINT ["redis-server"]
CMD ["--protected-mode no"]

