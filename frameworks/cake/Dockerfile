FROM php-framework-benchmark

ENV DEBUG false

RUN apt-get -y update \
    && apt-get install -y libicu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl

RUN setdocroot /var/www/app/webroot

