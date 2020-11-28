#!/bin/bash
set -e
docker build -t editorial-bias-dev .
docker run --rm  -p 8787:8787 -e DISABLE_AUTH=true -v "$PWD":/home/rstudio/project editorial-bias-dev
