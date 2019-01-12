#!/bin/bash

set -ex

cd "$(dirname "$0")"

cp -f php.ini /etc/php/7.1/cli/php.ini
cp -f php.ini /etc/php/7.1/fpm/php.ini
cp -f php-fpm.conf /etc/php/7.1/fpm/pool.d/www.conf

( cd /work/site && \
    mkdir -p storage/app && \
    mkdir -p storage/framework/{cache,sessions,views} && \
    mkdir -p storage/logs && \
    chown -R www-data:www-data storage && \
    rm -rf bootstrap/cache/* && \
    mkdir -p bootstrap/cache && \
    chown -R www-data:www-data bootstrap/cache )

mkdir -p /var/run/php

php-fpm7.1 -F
