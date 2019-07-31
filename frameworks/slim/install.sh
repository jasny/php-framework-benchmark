#!/bin/sh

set -e

VERSION="$1"
test -n "$VERSION" && DIR="v${VERSION//\*/x}" || DIR="latest"

rm -rf "$DIR"

composer create-project --no-interaction --prefer-dist --no-dev slim/slim-skeleton "$DIR" "$VERSION"

cp routes.php "$DIR/src/"
chmod ugo+rwX "$DIR/logs/"

composer update --no-interaction --no-dev --working-dir="$DIR"
composer dump-autoload --no-interaction --optimize --classmap-authoritative --no-dev --working-dir="$DIR"

