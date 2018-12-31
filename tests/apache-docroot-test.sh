#!/usr/bin/env bash

# set -o errexit
set -o nounset
# set -o pipefail
# set -o xtrace

# First, lets do some sanity checking
if [[ $(echo "$@" | wc -w) -lt "1" ]]; then
  echo "[ERROR] This script requires 1 args: [docker container name]"
  exit 1
fi

declare _name="${1}"
declare _check=

# Store the actual modules in a local variable
_check=$(docker exec "${_name}" bash -c "apachectl -S 2>&1" | grep -m1 "does not exist")

if [[ -z "${_check}" ]]; then
  echo "[PASSED] - document root exists"
else
  echo "${_check}"
  echo "[FAIL] - document root does not exist"
  exit 1
fi
