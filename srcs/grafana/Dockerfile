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
RUN apk add wget libc6-compat rsync supervisor

RUN wget -c https://dl.influxdata.com/telegraf/releases/telegraf-1.14.1_linux_amd64.tar.gz
RUN tar -C . -xzf telegraf-1.14.1_linux_amd64.tar.gz
RUN chmod +x -R telegraf
RUN rsync -a /telegraf/ /
RUN rm -rf telegraf

RUN wget -c https://dl.grafana.com/oss/release/grafana-7.5.2.linux-amd64.tar.gz
RUN tar -C . -xzf grafana-7.5.2.linux-amd64.tar.gz && rm -rf grafana-7.5.2.linux-amd64.tar.gz
RUN mv grafana-7.5.2 grafana
RUN chmod +x -R grafana
RUN mv grafana/bin/grafana-server /usr/local/bin

COPY ./supervisor.conf /etc/supervisor.conf
COPY ./telegraf.conf /etc/telegraf/telegraf.conf
COPY ./grafana.db /grafana/data/
COPY begin.sh ./tmp/
RUN chmod 777 ./tmp/begin.sh

EXPOSE 3000

CMD ./tmp/begin.sh
