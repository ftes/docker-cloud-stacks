#!/bin/bash
# expects env vars $NAME, $DOMAIN and $EMAIL

export TMP_FILE=`mktemp`
export MYSQL_ROOT_PASSWORD=`openssl rand -base64 32`
envsubst < wordpress      > $TMP_FILE; docker-cloud stack up -n $NAME -f $TMP_FILE --sync

sleep 10
xdg-open "http://$DOMAIN"
