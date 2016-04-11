#!/bin/bash
# input: output-dir ssh-user@server stack-name

OUTPUT=${1:-.}
SSH=${2:-root@ftes.de}
STACK=${3:-wordpress-trustedcomputing}

TMP_DIR=`ssh $SSH mktemp -d`
RAND=`date +%s | sha256sum | base64 | head -c 10`

echo "docker-cloud run -n $STACK-backup-$RAND -v $TMP_DIR:/backups --volumes-from=wordpress.$STACK --link=mysql.$STACK:mysql aveltens/wordpress-backup"
docker-cloud run -n $STACK-backup-$RAND -v $TMP_DIR:/backups --volumes-from=wordpress.$STACK --link=mysql.$STACK:mysql --sync aveltens/wordpress-backup

echo "docker-cloud exec $STACK-backup-$RAND-1 backup"
docker-cloud exec $STACK-backup-$RAND-1 backup > /dev/null

echo "scp $SSH:$TMP_DIR/* $OUTPUT"
scp $SSH:$TMP_DIR/* $OUTPUT

echo "docker-cloud service terminate $STACK-backup-$RAND"
docker-cloud service terminate $STACK-backup-$RAND
