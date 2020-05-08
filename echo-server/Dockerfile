FROM node

LABEL maintainer="Mars <11@boxue.io>"
LABEL description="The echo server that creates socket connection between clients and boxue server."

#RUN DEBIAN_FRONTEND=noninteractive curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
#    apt-get install -y nodejs && \
#    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN npm install -g laravel-echo-server
COPY ./laravel-echo-server.json /root

ENTRYPOINT ["laravel-echo-server"]
CMD ["start", "--force", "--dir=/root"]

