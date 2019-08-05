#!/bin/sh

set -e

VERSION="$1"
test -n "$VERSION" && DIR="v${VERSION//\*/x}" || DIR="latest"

rm -rf "$DIR"

composer create-project --no-interaction --prefer-dist cakephp/app "$DIR" "$VERSION"

cp HelloController.php "$DIR/src/Controller/"

composer update --no-interaction --working-dir="$DIR"


