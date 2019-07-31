FROM php:7-apache

ENV CI_ENV production

RUN a2enmod rewrite
RUN sed -ri -e 's!/var/www/html!/var/www/app!g' /etc/apache2/sites-available/*.conf /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

