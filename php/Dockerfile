FROM wordpress:6.0-php8.1-fpm
ARG xdebugmode

RUN apt-get update && \
    apt-get -y install git 

RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp
RUN chmod 755 /usr/local/bin/wp && \
    mkdir -p /var/www/.wp-cli/cache/ && \
    chown -R www-data:www-data /var/www/.wp-cli/cache/

RUN if [ "$xdebugmode" = "true" ]; then \
    cd /tmp && \
    git clone https://github.com/xdebug/xdebug.git && \
    cd xdebug && \
    git checkout xdebug_3_1 && \
    phpize && \
    ./configure --enable-xdebug && \
    make && \
    make install && \
    rm -rf /tmp/xdebug; \
    fi

COPY php.ini /usr/local/etc/php/php.ini
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

RUN if [ "$xdebugmode" = "true" ]; then docker-php-ext-enable xdebug; fi
