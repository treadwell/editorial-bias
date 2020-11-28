#!/bin/bash

if [ -z "$USER" -o -z "$UID" -o -z "$GID" -o -z "$PASSWORD" ]
then
    echo "Missing env vars: USER, UID, GID, PASSWORD"
    exit 1
fi

useradd $USER -u $UID -g $GID
echo "$USER:$PASSWORD" | chpasswd

mkdir -p /home/$USER/.rstudio

/usr/lib/rstudio-server/bin/rserver \
    --auth-minimum-user-id $UID \
    --server-daemonize 0
