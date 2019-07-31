FROM php:7-apache

ARG VERSION
ENV DEBUG false

RUN a2enmod rewrite
COPY app/ /var/www/html/

COPY $VERSION /root/phalcon
RUN cd /root/phalcon/build && ./install

