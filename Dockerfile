FROM php:7.3-apache
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
        libxslt-dev \
        libjpeg-dev \
		# libpng12-dev \
        git \
        vim \
        cron \
        sendmail-bin \
        sendmail \
        sendmail-cf \
        m4

# Add all of the php specific packages
RUN docker-php-ext-install mysqli pdo pdo_mysql zip \
    && docker-php-ext-install -j$(nproc) iconv \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install xsl \
	&& docker-php-ext-install -j$(nproc) gd

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

RUN composer global init

# Install Pecl stuff
RUN pecl install xdebug-beta

# Enable Apache mod_rewrite
RUN a2enmod rewrite
RUN a2enmod headers

# Server configuration overrides
ADD config/httpd.conf /etc/apache2/sites-available/000-default.conf
ADD config/php.ini /usr/local/etc/php/conf.d/custom.ini
ADD scripts/sendmail.sh /home/sendmail.sh
ADD scripts/setup.sh /home/setup.sh

# Local administration environment overrides
ADD config/.vimrc /root/.vimrc
ADD config/.bashrc /root/.bashrc

# Sanity
RUN mkdir -p /var/www/html/web
ADD resources/index.html /var/www/html/web/index.html

# for webgrind output
RUN cd /opt && git clone https://github.com/jokkedk/webgrind.git
RUN cd /opt/webgrind && composer install
RUN cd /var/www/html/web && ln -s /opt/webgrind /var/www/html/web/webgrind

# Set up docroot
RUN mkdir -p /var/www/html/web
ADD resources/index.html /var/www/html/web/index.html
RUN /home/setup.sh
WORKDIR /var/www/html
