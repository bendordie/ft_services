FROM alpine:3.11.7

RUN apk update && apk upgrade
RUN apk add openrc mysql mysql-client
RUN apk add wget rsync supervisor libc6-compat

RUN wget -c https://dl.influxdata.com/telegraf/releases/telegraf-1.14.1_linux_amd64.tar.gz
RUN tar -C . -xzf telegraf-1.14.1_linux_amd64.tar.gz
RUN chmod +x -R telegraf
RUN rsync -a /telegraf/ /
RUN rm -rf telegraf
RUN rm -rf telegraf-1.14.1_linux_amd64.tar.gz 

RUN mkdir -p /data/mysql
RUN chmod +x /data

COPY wp_db.sql /
RUN chmod +x /wp_db.sql

RUN mkdir -p /etc/mysql/mysql.conf.d
COPY ./mydb.cnf /etc/mysql/my.cnf

COPY ./supervisor.conf /etc/supervisor.conf
COPY ./telegraf.conf /etc/telegraf/telegraf.conf
COPY ./begin.sh ./tmp
RUN chmod 777 ./tmp/begin.sh

EXPOSE 3306

CMD ./tmp/begin.sh