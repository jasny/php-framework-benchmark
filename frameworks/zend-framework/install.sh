#!/bin/sh

set -e

VERSION="$1"
test -n "$VERSION" && DIR="v${VERSION//\*/x}" || DIR="latest"

rm -rf "$DIR"

composer create-project --no-interaction --prefer-dist --no-dev --no-scripts zendframework/skeleton-application "$DIR" "$VERSION"

cp module.config.php "$DIR/module/Application/config/"
cp HelloController.php "$DIR/module/Application/src/Controller/"

chmod ugo+rwX "$DIR/data" -R

pushd "$DIR"
composer update --no-interaction

php artisan optimize --force
php artisan config:cache
php artisan route:cache

composer dump-autoload --no-interaction --optimize --classmap-authoritative --no-dev
popd

