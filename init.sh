#!/bin/bash

set -ex

echo 'export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8' >> ~/.bashrc

# update apt.list
echo 'deb http://archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ trusty-security main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse

# curl new version
deb http://ppa.launchpad.net/costamagnagianfranco/ettercap-stable-backports/ubuntu trusty main
deb http://ppa.launchpad.net/ondrej/php/ubuntu trusty main

# newrelic
deb http://apt.newrelic.com/debian/ newrelic non-free
' > /etc/apt/sources.list
rm -rf /etc/apt/sources.list.d/*

apt-get update

# install deps
while ! apt-get install -y --force-yes git nginx curl supervisor newrelic-php5 \
    php7.1  php7.1-dev  php7.1-gd php-pear php7.1-gmp  php7.1-curl php7.1-mysql php7.1-fpm php7.1-opcache \
    php7.1-mbstring php7.1-bcmath php7.1-mcrypt php7.1-cli php7.1-json php7.1-xml php7.1-zip zlib1g-dev ; do

    /bin/true
done

pecl install grpc protobuf
