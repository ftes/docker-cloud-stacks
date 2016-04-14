#!/bin/bash
# set variables from env.sh as environment variables
. env.sh

# print commands
set -x

docker-cloud stack terminate authorizedkeys
docker-cloud stack terminate nginx-proxy
docker-cloud stack terminate $NAME
