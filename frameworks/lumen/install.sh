#!/bin/sh

set -e

VERSION="$1"
test -n "$VERSION" && DIR="v${VERSION//\*/x}" || DIR="latest"

rm -rf "$DIR"

composer create-project --no-interaction --prefer-dist --no-dev laravel/lumen "$DIR" "$VERSION"

cp .env.prod "$DIR/.env"
cp routes.php "$DIR/routes/web.php"
chmod ugo+rwX "$DIR/storage/" -R

composer update --no-interaction --working-dir="$DIR"

