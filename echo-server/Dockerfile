FROM node

LABEL maintainer="Mars <11@boxue.io>"
LABEL description="The echo server that creates socket connection between clients and boxue server."

ENV TZ=Asia/Shanghai
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime

RUN npm install -g laravel-echo-server
COPY ./laravel-echo-server.json /root

ENTRYPOINT ["laravel-echo-server"]
CMD ["start", "--force", "--dir=/root"]

