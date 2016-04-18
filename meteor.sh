#!/bin/bash
# set variables from env.sh as environment variables
. env.sh
export REPO=${REPO:-"https://github.com/ftes/meteor-test"}

# print commands
set -x

envsubst < meteor      > $TMP_FILE; docker-cloud stack up -n $NAME -f $TMP_FILE

#xdg-open "http://$DOMAIN"
