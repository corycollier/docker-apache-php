#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace

# First, lets do some sanity checking
if [[ $(echo "$@" | wc -w) -lt "1" ]]; then
  echo "[ERROR] This script requires 1 args: [docker container name] "
  exit 1
fi

declare _name="${1}"
declare _result=

_result=$(docker exec "${_name}" bash -c "which cron | grep cron")

# If the actual version is our checked version, print a happy message
if [[ -n "${_result}" ]]; then
  echo "[PASS] - cron found"

# If not though, get mad
else
  echo "[FAIL] git not found"
  exit 1
fi
