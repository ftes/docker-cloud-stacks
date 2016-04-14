#!/bin/bash
# set variables from env.sh as environment variables
. env.sh

# print commands
set -x

envsubst < authorizedkeys > $TMP_FILE; docker-cloud stack up -n authorizedkeys -f $TMP_FILE

# wait until nginx has started before running wordpress (--sync)
envsubst < nginx-proxy    > $TMP_FILE; docker-cloud stack up -n nginx-proxy -f $TMP_FILE --sync
set +x; ./wordpress.sh; set -x

#xdg-open "http://$DOMAIN"
