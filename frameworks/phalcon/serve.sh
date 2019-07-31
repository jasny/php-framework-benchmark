#!/bin/sh

NAME=$1
VERSION=$2
PORT=$3

docker run -d -p "$PORT":80 --name "$NAME" "php-framework-benchmark.phalcon:$VERSION"

