#!/bin/bash

export DOMAIN=${DOMAIN:-tc.ftes.de}
export EMAIL=${EMAIL:-admin@ftes.de}
export NAME=${NAME:-wordpress-trustedcomputing}
export SSH_PUB_KEY=`cat ~/.ssh/id_rsa.pub`
export MYSQL_ROOT_PASSWORD=`openssl rand -base64 32`

TMP_FILE=`mktemp`

envsubst < authorizedkeys > $TMP_FILE; docker-cloud stack up -n authorizedkeys -f $TMP_FILE

# wait until nginx has started before running wordpress (--sync)
envsubst < nginx-proxy    > $TMP_FILE; docker-cloud stack up -n nginx-proxy -f $TMP_FILE --sync
envsubst < wordpress      > $TMP_FILE; docker-cloud stack up -n $NAME -f $TMP_FILE

xdg-open "http://$DOMAIN"
echo
