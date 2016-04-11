#!/bin/bash
# expects env vars $NAME, $DOMAIN and $EMAIL

export DOMAIN=${DOMAIN:-tc.ftes.de,ftes.de,www.ftes.de}
export EMAIL=${EMAIL:-admin@ftes.de}
export NAME=${NAME:-wordpress-trustedcomputing}

export TMP_FILE=`mktemp`
export MYSQL_ROOT_PASSWORD=`openssl rand -base64 32`
envsubst < wordpress      > $TMP_FILE; docker-cloud stack up -n $NAME -f $TMP_FILE

#xdg-open "http://$DOMAIN"
