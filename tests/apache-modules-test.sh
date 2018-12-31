#!/usr/bin/env bash

set -o errexit
set -o nounset
# set -o pipefail
# set -o xtrace

# First, lets do some sanity checking
if [[ $(echo "$@" | wc -w) -lt "1" ]]; then
  echo "[ERROR] This script requires 1 args: [docker container name]"
  exit 1
fi

declare _name="${1}"
declare _actual_modules=
declare _check_modules=(
  "rewrite"
  "php7_module"
)

# Store the actual modules in a local variable
_actual_modules=$(docker exec "${_name}" bash -c "apachectl -M 2>&1")

# Iterate over our check modules to make sure they're in the container
for _module in ${_check_modules[@]}; do
  if [[ -n $(echo "${_actual_modules}" | grep "${_module}") ]]; then
    echo "[PASS] - apache has module [${_module}]"
  else
    echo "[FAIL] - module [${_module}] not found"
  fi
done
