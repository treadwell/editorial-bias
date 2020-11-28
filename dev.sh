#!/bin/bash
set -e

if [[ "$1" == "interactive" ]]
then
    DOCKERARGS="-ti"
    shift
fi

docker build -t editorial-bias-dev .
docker run $DOCKERARGS --rm -v "$PWD":/project -p 8787:8787 editorial-bias-dev $@
