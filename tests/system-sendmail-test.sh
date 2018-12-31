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

# Try to use the container to send an email (to me :))
docker exec "${_name}" bash -c "echo 'test me' | sendmail -v corycollier@corycollier.com"

if [[ "$?" -gt "0" ]]; then
  echo "[FAIL] - failed to send mail"
  exit 1
else
  echo "[PASS] - mail sent"
fi
