FROM php:7-apache

ARG VERSION
ENV DEBUG false

RUN a2enmod rewrite
COPY app/ /var/www/html/

RUN sed -ri -e 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/*.conf /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

COPY $VERSION /root/phalcon
RUN cd /root/phalcon/build && ./install && echo "extension=phalcon" > /usr/local/etc/php/conf.d/phalcon.ini

