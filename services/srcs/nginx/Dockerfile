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
RUN apk add nginx supervisor
RUN apk add openssl wget rsync libc6-compat

RUN wget -c https://dl.influxdata.com/telegraf/releases/telegraf-1.14.1_linux_amd64.tar.gz
RUN tar -C . -xzf telegraf-1.14.1_linux_amd64.tar.gz
RUN chmod +x -R telegraf
RUN rsync -a /telegraf/ /
RUN rm -rf telegraf
RUN rm -rf telegraf-1.14.1_linux_amd64.tar.gz 

RUN openssl req -newkey rsa:2048 -x509 -sha256 -days 30 -nodes -out /etc/ssl/certs/certificate.crt -keyout /etc/ssl/certs/public.key -subj "/C=RU/ST=TATARSTAN/L=KAZAN/O=Security/OU=IT Department/CN=localhost"

COPY ./nginx_config ./etc/nginx/conf.d/default.conf
COPY ./supervisor.conf ./etc
COPY ./telegraf.conf /etc/telegraf/telegraf.conf

COPY ./begin.sh ./
RUN chmod +x ./begin.sh
RUN mkdir -p /run/nginx

EXPOSE 80 443

CMD ./begin.sh
