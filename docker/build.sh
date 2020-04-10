#!/bin/sh

# create default user
addgroup -S abc
adduser -G abc -g 'default user' -h /aria2 -s /bin/sh -D -S abc
chown abc:abc /aria2 -R 
chown abc:abc /aria2/* -R