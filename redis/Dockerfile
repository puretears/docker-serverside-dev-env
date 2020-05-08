ARG baseImg
FROM $baseImg

LABEL maintainer="Mars <11@boxue.io>"
LABEL description="Redis channel that deliver event from Boxue server to clients."

RUN DEBIAN_FRONTEND=noninteractive apt update && \
    apt-get install -y redis-server && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["redis-server"]
CMD ["--protected-mode no"]

