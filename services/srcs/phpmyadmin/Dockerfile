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
RUN apk add nginx supervisor wget rsync libc6-compat openssl
RUN apk add --no-cache php7 php7-fpm php7-json php7-mysqli php7-curl php7-gd php7-intl php7-mbstring php7-soap php7-xml php7-xmlrpc php7-zip php7-iconv php7-phar php7-session

RUN wget -c https://dl.influxdata.com/telegraf/releases/telegraf-1.14.1_linux_amd64.tar.gz
RUN tar -C . -xzf telegraf-1.14.1_linux_amd64.tar.gz
RUN chmod +x -R telegraf
RUN rsync -a /telegraf/ /
RUN rm -rf telegraf
RUN rm -rf telegraf-1.14.1_linux_amd64.tar.gz 

RUN wget -c https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz
RUN tar -xvf phpMyAdmin-5.0.4-all-languages.tar.gz && rm -rf phpMyAdmin-5.0.4-all-languages.tar.gz
RUN mv phpMyAdmin-5.0.4-all-languages ./var/www/phpmyadmin

COPY ./config.inc.php ./var/www/phpmyadmin/config.inc.php
COPY ./nginx_config ./etc/nginx/conf.d/default.conf
COPY ./supervisor.conf /etc/supervisor.conf
COPY ./telegraf.conf /etc/telegraf/telegraf.conf
COPY ./begin.sh ./tmp

RUN chmod 777 ./tmp/begin.sh
RUN mkdir -p /run/nginx

EXPOSE 5000

CMD ./tmp/begin.sh
