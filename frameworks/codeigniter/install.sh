#!/bin/sh

set -e

VERSION="$1"
test -n "$VERSION" && DIR="v${VERSION//\*/x}" || DIR="latest"

rm -rf "$DIR"

composer create-project --no-interaction --prefer-dist --no-dev codeigniter/framework "$DIR" "$VERSION"

cp .htaccess "$DIR"
cp Hello.php "$DIR/application/controllers/"
rm -rf "$DIR/user_guide"

composer update --no-interaction --working-dir="$DIR"

