FROM mysql 

LABEL maintainer="Mars <11@boxue.io>"
LABEL description="MySQL of Boxue website and app backend"

COPY secure_mysql.sql /docker-entrypoint-initdb.d/

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

