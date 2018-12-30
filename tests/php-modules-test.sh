#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace

declare _modules=(
  "Core"
  "ctype"
  "curl"
  "date"
  "dom"
  "fileinfo"
  "filter"
  "ftp"
  "gd"
  "hash"
  "iconv"
  "json"
  "libxml"
  "mbstring"
  "mysqli"
  "mysqlnd"
  "openssl"
  "pcre"
  "PDO"
  "pdo_mysql"
  "pdo_sqlite"
  "Phar"
  "posix"
  "readline"
  "Reflection"
  "session"
  "SimpleXML"
  "SPL"
  "sqlite3"
  "standard"
  "tokenizer"
  "xdebug"
  "xml"
  "xmlreader"
  "xmlwriter"
  "xsl"
  "zip"
  "zlib"
)

for _module in ${_modules[@]}; do
  if [[ -n $(php -m | grep "${_module}") ]]; then
    echo "[PASS] - php has module [${_module}]"
  else
    echo "[ERROR] - module [${_module}] not found"
  fi
done
