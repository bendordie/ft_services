# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cshells <cshells@student.21-school>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/04 17:08:10 by cshells           #+#    #+#              #
#    Updated: 2021/02/27 15:28:24 by cshells          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.11.7

RUN apk update && apk upgrade
RUN apk add wget libc6-compat rsync
RUN apk add influxdb supervisor

RUN wget -c https://dl.influxdata.com/telegraf/releases/telegraf-1.14.1_linux_amd64.tar.gz
RUN tar -C . -xzf telegraf-1.14.1_linux_amd64.tar.gz
RUN chmod +x -R telegraf
RUN rsync -a /telegraf/ /
RUN rm -rf telegraf
RUN rm -rf telegraf-1.14.1_linux_amd64.tar.gz 

RUN mkdir -p /etc/influxdb
RUN mkdir -p /var/lib/influxdb

COPY ./supervisor.conf /etc/supervisor.conf
COPY ./telegraf.conf /etc/telegraf/telegraf.conf
COPY begin.sh ./tmp/
RUN chmod 777 ./tmp/begin.sh

EXPOSE 8086

CMD ./tmp/begin.sh
