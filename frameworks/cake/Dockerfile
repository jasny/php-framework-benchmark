FROM php:7-apache

ENV DEBUG false

RUN apt-get -y update \
    && apt-get install -y libicu-dev\
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl

RUN a2enmod rewrite
RUN sed -ri -e 's!/var/www/html!/var/www/app/webroot!g' /etc/apache2/sites-available/*.conf /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

