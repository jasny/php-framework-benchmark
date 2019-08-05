FROM php-framework-benchmark

ARG VERSION
ENV DEBUG false

COPY app/ /var/www/html/
RUN setdocroot /var/www/html/public

COPY $VERSION /root/ice
RUN cd /root/ice/build/php7 && ./install && echo "extension=ice" > /usr/local/etc/php/conf.d/ice.ini

