#!/bin/sh

set -e

VERSION="$1"
test -n "$VERSION" && DIR="v${VERSION//\*/x}" || DIR="latest"

rm -rf "$DIR"

# Yii 2.0 requires composer-asset-plugin
composer global require "fxp/composer-asset-plugin:1.*"

composer create-project --no-interaction --prefer-dist --no-dev yiisoft/yii2-app-basic "$DIR" "$VERSION"

cp HelloController.php "$DIR/controllers/"

composer update --no-interaction --working-dir="$DIR"
composer dump-autoload --no-interaction --optimize --classmap-authoritative --no-dev --working-dir="$DIR"

