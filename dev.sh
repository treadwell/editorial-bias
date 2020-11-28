#!/bin/bash
set -e

if [[ "$1" == "interactive" ]]
then
    DOCKERARGS="-ti"
    shift
fi

docker build                       \
    -t editorial-bias-dev .        \
    --build-arg USER=$USER         \
    --build-arg UID=$(id -u $USER) \
    --build-arg GID=$(id -g $USER)

docker run $DOCKERARGS            \
    --rm                          \
    -p 8787:8787                  \
    -e USER=$USER                 \
    -e UID=$(id -u $USER)         \
    -e GID=$(id -g $USER)         \
    -v "$PWD":/home/$USER/project \
    editorial-bias-dev $@
