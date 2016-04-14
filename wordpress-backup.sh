#!/bin/bash
# input: output-dir ssh-user@server stack-name

# set variables from env.sh as environment variables
. env.sh

OUTPUT=${1:-.}
SSH=${2:-$SSH}
NAME=${3:-$NAME}
TMP_DIR=`ssh $SSH mktemp -d`
RAND=`date +%s | sha256sum | base64 | head -c 10`

# print commands
set -x

docker-cloud run -n backup-$RAND -v $TMP_DIR:/backups --volumes-from=wordpress.$NAME --link=mysql.$NAME:mysql --sync aveltens/wordpress-backup

docker-cloud exec backup-$RAND-1 backup > /dev/null

scp $SSH:$TMP_DIR/* $OUTPUT

docker-cloud service terminate backup-$RAND
