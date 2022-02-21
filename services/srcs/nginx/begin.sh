#!/bin/sh

#set access rights
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

/usr/bin/supervisord -c /etc/supervisor.conf
