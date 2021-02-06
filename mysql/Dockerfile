FROM mysql

LABEL maintainer="Mars <11@boxue.io>"
LABEL description="DB service of the application."

COPY secure_mysql.sql /docker-entrypoint-initdb.d/

ENV TZ=Asia/Shanghai
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
