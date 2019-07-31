#!/bin/sh

set -e

VERSION="$1"
test -n "$VERSION" && DIR="v${VERSION//\*/x}" || DIR="latest"

rm -rf "$DIR"

composer create-project --no-interaction --prefer-dist  --no-dev --no-scripts iceframework/framework "$DIR" "$VERSION"

for SCRIPT in "$DIR"/build/*/install; do
  sed -i -e 's/-Wall //' "$SCRIPT" # don't need to see all the compile warnings
  sed -i -e 's/sudo //g' "$SCRIPT" # no sudo in docker container; already root
done

