FROM php:7.1-apache
MAINTAINER Cory Collier <corycollier@corycollier.com>

# Do all of the global system package installations
RUN apt -y update \
    && apt -y install \
        libzip-dev \
        libpng-dev \
        zlib1g-dev \
        libfreetype6-dev \
		libjpeg62-turbo-dev \
		libmcrypt-dev \
		# libpng12-dev \
        git \
        vim

# Add all of the php specific packages
RUN docker-php-ext-install mysqli pdo pdo_mysql zip \
    && docker-php-ext-install -j$(nproc) iconv  \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

RUN composer global init

# RUN pecl install mcrypt

# Enable Apache mod_rewrite
RUN a2enmod rewrite
RUN a2enmod headers

# Server configuration overrides
ADD config/httpd.conf /etc/apache2/es-available/000-default.conf
ADD ./config/php.ini /usr/local/etc/php/conf.d/custom.ini
ADD scripts/sendmail.sh /home/sendmail.sh

# Local administration environment overrides
ADD config/.vimrc /root/.vimrc
ADD config/.bashrc /root/.bashrc

# Set the workdir
WORKDIR /var/www/html
