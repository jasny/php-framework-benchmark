#!/bin/sh

set -e

VERSION="$1"
test -n "$VERSION" && DIR="v${VERSION//\*/x}" || DIR="latest"

rm -rf "$DIR"

# Yii 2.0 requires composer-asset-plugin
composer global require "fxp/composer-asset-plugin:1.*"

composer create-project --no-interaction --prefer-dist --no-dev yiisoft/yii2-app-basic "$DIR" "$VERSION"

cp HelloController.php "$DIR/controllers/"
cp .htaccess "$DIR/web/"

sed -is 's~defined~//~g' "$DIR/web/index.php"

composer update --no-interaction --working-dir="$DIR"
