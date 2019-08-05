FROM php-framework-benchmark

RUN setdocroot /var/www/app

RUN pecl -q install psr-beta && \
    echo 'extension=psr' > /usr/local/etc/php/conf.d/10-psr.ini && \
    pecl -q install http_message-beta && \
    echo 'extension=http_message' > /usr/local/etc/php/conf.d/20-http_messge.ini

