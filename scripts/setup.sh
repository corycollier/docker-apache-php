#!/usr/bin/env bash

declare _APACHE_VERSION=

_APACHE_VERSION=$(apachectl -V | sed -n 's/.*Apache\/\([0-9].[0-9].[0-9]\).*/\1/p')

echo "${_APACHE_VERSION}"

sed -i \
  -e "s/PHP_VERSION/${PHP_VERSION}/g" \
  -e "s/APACHE_VERSION/${_APACHE_VERSION}/g" \
  /var/www/html/web/index.html
