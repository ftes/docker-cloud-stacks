export SSH=${SSH:-root@ftes.de}
export TMP_FILE=`mktemp`
export NAME=${NAME:-wordpress-blog}
export PASSWORD=$RANDOM #`openssl rand -base64 32`
export DOMAIN=${DOMAIN:-ftes.de}
export EMAIL=${EMAIL:-admin@ftes.de}
export SSH_PUB_KEY=`cat ~/.ssh/id_rsa.pub`
