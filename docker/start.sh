#!/bin/sh

# Change user puid
setids() {
    PUID=${PUID:-1000}
    PGID=${PGID:-1000}
	echo "changing abc to $PUID:$PGID"
    groupmod -o -g "$PGID" abc
    usermod -o -u "$PUID" abc
}

setids

UMASK_SET=${UMASK_SET:-022}
echo "changing umask to $UMASK_SET"
umask "$UMASK_SET"

su -c "/docker/aria2.sh" abc
