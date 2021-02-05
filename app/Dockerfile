FROM ubuntu:20.04

LABEL maintainer="Mars <11@boxue.io>"
LABEL description="Base image of Boxue docker containers for server side development."

# Install Laravel dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        git \
        zip \
        wget \
        curl \
        cron \
        unzip \
        net-tools \
        iputils-ping \
        build-essential \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

CMD ["/bin/bash"]

