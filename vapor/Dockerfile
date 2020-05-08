ARG baseImg
FROM $baseImg

LABEL maintainer="Mars <11@boxue.io>"
LABEL description="Swift Vapor environment."

RUN apt-get update && \
    apt-get install wget software-properties-common gnupg2 libcurl4-openssl-dev -y

# Vapor setup
RUN /bin/bash -c "$(wget -qO- https://apt.vapor.sh)"

# Install vapor and clean
RUN apt-get update && apt-get install swift vapor -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN vapor --help

