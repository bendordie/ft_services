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
RUN apk add openssl wget libc6-compat rsync
RUN apk add vsftpd supervisor

RUN wget -c https://dl.influxdata.com/telegraf/releases/telegraf-1.14.1_linux_amd64.tar.gz
RUN tar -C . -xzf telegraf-1.14.1_linux_amd64.tar.gz
RUN chmod +x -R telegraf
RUN rsync -a /telegraf/ /
RUN rm -rf telegraf
RUN rm -rf telegraf-1.14.1_linux_amd64.tar.gz 

RUN openssl req -newkey rsa:2048 -x509 -sha256 -days 30 -nodes -out /etc/ssl/certs/vsftpd_cert.crt -keyout /etc/ssl/private/vsftpd_pub.key -subj "/C=RU/ST=TATARSTAN/L=KAZAN/O=Security/OU=IT Department/CN=localhost"

RUN mkdir -p /etc/ftps/chel
RUN adduser --home=/etc/ftps/chel -D chel
RUN echo "chel:chel" | chpasswd

RUN mkdir -p /etc/vsftpd

COPY vsftpd.conf ./etc/vsftpd/vsftpd.conf
COPY ./supervisor.conf /etc/supervisor.conf
COPY ./telegraf.conf /etc/telegraf/telegraf.conf
COPY begin.sh ./tmp/
RUN chmod 777 ./tmp/begin.sh

EXPOSE 21 62000-62002

CMD ./tmp/begin.sh
