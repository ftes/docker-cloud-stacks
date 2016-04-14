#!/bin/bash
# set variables from env.sh as environment variables
. env.sh

# print commands
set -x

envsubst < wordpress      > $TMP_FILE; docker-cloud stack up -n $NAME -f $TMP_FILE

#xdg-open "http://$DOMAIN"
