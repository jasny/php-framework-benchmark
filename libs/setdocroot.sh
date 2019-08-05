#!/bin/sh

sed -ri -e "s!/var/www/html!$1!g" /etc/apache2/sites-available/*.conf /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

