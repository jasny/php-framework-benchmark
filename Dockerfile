FROM php:7-apache

RUN a2enmod rewrite
RUN sed -ri -e "s/KeepAlive On/KeepAlive Off/g" /etc/apache2/apache2.conf

RUN mkdir -p /var/www/libs/
COPY libs/output_data.php /var/www/libs/
RUN echo 'auto_append_file="/var/www/libs/output_data.php"' > /usr/local/etc/php/conf.d/output_data.ini

COPY libs/setdocroot.sh /usr/local/bin/setdocroot
COPY libs/composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/setdocroot /usr/local/bin/composer

RUN apt-get update -y \
    && apt-get install -y git unzip libzip-dev \
    && docker-php-ext-configure zip && docker-php-ext-install zip

