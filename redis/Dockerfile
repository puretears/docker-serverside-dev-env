FROM redis:latest

LABEL maintainer="Mars <11@boxue.io>"
LABEL description="Redis channel that deliver event from Boxue server to clients."

ENV TZ=Asia/Shanghai
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime

ENTRYPOINT ["redis-server"]
CMD ["--protected-mode no"]

