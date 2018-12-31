#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace

# First, lets do some sanity checking
if [[ $(echo "$@" | wc -w) -lt "1" ]]; then
  echo "[ERROR] This script requires 1 args: [docker container name]"
  exit 1
fi

declare _name="${1}"
declare _actual_modules=
declare _check_modules=(
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

# Store the actual modules in a local variable
_actual_modules=$(docker exec "${_name}" bash -c "php -m")

# Iterate over our check modules to make sure they're in the container
for _module in "${_check_modules[@]}"; do
  if [[ -n $(echo "${_actual_modules}" | grep "${_module}") ]]; then
    echo "[PASS] - php has module [${_module}]"
  else
    echo "[FAIL] - module [${_module}] not found"
  fi
done
