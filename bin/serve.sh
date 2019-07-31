#!/bin/sh

CMD="$1"
TARGET="$2"
FRAMEWORK="${TARGET%:*}"
VERSION="${TARGET##*:}"

case "$VERSION" in
  "")     DIR="latest";;
  [0-9]*) DIR="v${VERSION//\*/x}";;
  *)      DIR="$VERSION";;
esac

case "$CMD" in
  start)
    pushd "frameworks/$FRAMEWORK/"
    source "serve.sh" "php-framework-benchmark.$FRAMEWORK-$DIR" "$DIR" 8081
    popd
    ;;
  stop)
    docker stop "php-framework-benchmark.$FRAMEWORK-$DIR"
    docker rm "php-framework-benchmark.$FRAMEWORK-$DIR"
    ;;
  *)
    >&2 echo "USAGE serve.sh {start|stop} FRAMEWORK[:VERSION]"
    exit 99
    ;;
esac

