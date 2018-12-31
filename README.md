# docker-apache-php
Generic Apache/PHP Web Host

![build status](https://gitlab.com/corycollier/docker-apache-php/badges/7.1.x-dev/build.svg)

Based of the official image from php - [7.1-apache](https://github.com/docker-library/php/blob/a280ab8e8790052338ce59a1fee739df8f831f16/7.1/stretch/apache/Dockerfile)

Adding the following:
* composer
* sendmail
* git
* vim
* cron
* webgrind

```
[PHP Modules]
Core
ctype
curl
date
dom
fileinfo
filter
ftp
gd
hash
iconv
json
libxml
mbstring
mysqli
mysqlnd
openssl
pcre
PDO
pdo_mysql
pdo_sqlite
Phar
posix
readline
Reflection
session
SimpleXML
SPL
sqlite3
standard
tokenizer
xdebug
xml
xmlreader
xmlwriter
xsl
zip
zlib

[Zend Modules]
Xdebug
```
