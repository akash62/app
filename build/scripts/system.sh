#!/usr/bin/env bash

EXIT_CODE=0
HOST_APP_VOLUME=${PWD}$(dirname $0)/../..

set -v

docker-compose run php composer diagnose || EXIT_CODE=1
docker run -v ${HOST_APP_VOLUME}/build/scripts/lint.sh:/tmp/FileToBeChecked chrisdaish/shellcheck || EXIT_CODE=1
docker run -v ${HOST_APP_VOLUME}/build/scripts/build.sh:/tmp/FileToBeChecked chrisdaish/shellcheck || EXIT_CODE=1
docker run -v ${HOST_APP_VOLUME}/build/scripts/test.sh:/tmp/FileToBeChecked chrisdaish/shellcheck || EXIT_CODE=1
docker run -v ${HOST_APP_VOLUME}/build/scripts/deploy.sh:/tmp/FileToBeChecked chrisdaish/shellcheck || EXIT_CODE=1

set +v

exit ${EXIT_CODE}