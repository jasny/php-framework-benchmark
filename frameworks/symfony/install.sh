#!/bin/sh

set -e

VERSION="$1"
test -n "$VERSION" && DIR="v${VERSION//\*/x}" || DIR="latest"

rm -rf "$DIR"

composer create-project --no-interaction --prefer-dist --no-dev symfony/skeleton "$DIR" "$VERSION"

cp HelloController-v4.php "$DIR/src/Controller/"
cp routes.yaml "$DIR/config"
cp .htaccess "$DIR/public"

composer update --no-interaction --working-dir="$DIR"

