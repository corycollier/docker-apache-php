#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace

# First, lets do some sanity checking
if [[ $(echo "$@" | wc -w) -lt "2" ]]; then
  echo "[ERROR] This script requires 2 args: [docker container name] [version of php to check]"
  exit 1
fi

declare _name="${1}"
declare _check_version="${2}"
declare _actual_version=

_actual_version=$(docker exec "${_name}" bash -c "php -v | sed -n 's/PHP \([0-9].[0-9]\).*/\1/p'")

# If the actual version is our checked version, print a happy message
if [[ "${_actual_version}" = "${_check_version}" ]]; then
  echo "passed"

# If not though, get mad
else
  echo "[ERROR] given version [${_check_version}] not the actual version [${_actual_version}]"
  exit 1
fi
