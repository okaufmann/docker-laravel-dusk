FROM php:7.1

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install packages
RUN apt-get update -yqq && apt-get install -y git curl libcurl4-gnutls-dev libicu-dev libmcrypt-dev libvpx-dev libjpeg-dev libpng-dev  \
                        libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libexpat1-dev libbz2-dev \
                        libgmp3-dev libldap2-dev unixodbc-dev libpq-dev libsqlite3-dev libaspell-dev \
                        libsnmp-dev libpcre3-dev libtidy-dev -yqq bzip2 libfontconfig xvfb chromium libmagickwand-dev

# Install php environment
RUN docker-php-ext-install mbstring mcrypt pdo_mysql curl json intl gd xml zip bz2 opcache bcmath

# Install imagick
RUN pecl install imagick && docker-php-ext-enable imagick

# check installed modules
RUN php -m

# Install NVM
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.1.4
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

# install node and npm
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Install Composer Package manager
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php \
    php -r "unlink('composer-setup.php');" && mv composer.phar /usr/local/bin/composer

# Install chromium and X virtual framebuffer
# https://github.com/mark-adams/docker-chromium-xvfb/blob/master/images/base/Dockerfile
ADD xvfb-chromium /usr/bin/xvfb-chromium

RUN ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome \
    && chmod +x /usr/bin/google-chrome \
    && ln -s /usr/bin/xvfb-chromium /usr/bin/chromium-browser \
    && chmod +x /usr/bin/chromium-browser

    # confirm installation
RUN node -v
RUN npm -v
RUN php -m
RUN php -v