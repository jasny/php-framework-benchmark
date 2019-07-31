#!/bin/sh

set -e

VERSION="$1"
test -n "$VERSION" && DIR="v${VERSION//\*/x}" || DIR="latest"

rm -rf "$DIR"

composer create-project --no-interaction --prefer-dist --no-dev symfony/skeleton "$DIR" "$VERSION"

cp HelloController-v4.php "$DIR/src/Controller/"
cp routes.yaml "$DIR/config"
cp .htaccess "$DIR/public"

pushd "$DIR"
composer update --no-interaction --optimize-autoloader
php bin/console cache:clear --env=prod --no-debug
php bin/console cache:warmup --env=prod --no-debug
composer dump-autoload --no-interaction --optimize --classmap-authoritative --no-dev
popd

