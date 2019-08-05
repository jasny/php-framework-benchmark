FROM php-framework-benchmark

ARG VERSION
ENV DEBUG false

COPY app/ /var/www/html/

RUN setdocroot /var/www/html/public

COPY $VERSION /root/phalcon
RUN cd /root/phalcon/build && ./install && echo "extension=phalcon" > /usr/local/etc/php/conf.d/phalcon.ini

