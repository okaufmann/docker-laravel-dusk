#!/bin/bash

# Install git (the php image doesn't have it) which is required by composer
apt-get update -yqq
apt-get install git libcurl4-gnutls-dev libicu-dev libmcrypt-dev libvpx-dev libjpeg-dev libpng-dev  \ 
                        libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libexpat1-dev libbz2-dev \
                        libgmp3-dev libldap2-dev unixodbc-dev libpq-dev libsqlite3-dev libaspell-dev 
                        libsnmp-dev libpcre3-dev libtidy-dev -yqq bzip2 libfontconfig xvfb chromium

# Install mysql driver
# Here you can install any other extension that you need
docker-php-ext-install mbstring mcrypt pdo_mysql curl json intl gd xml zip bz2 opcache bcmath

# Install phpunit, the tool that we will use for testing
curl -Lo /usr/local/bin/phpunit https://phar.phpunit.de/phpunit.phar
chmod +x /usr/local/bin/phpunit

# Install Composer Package manager
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer
