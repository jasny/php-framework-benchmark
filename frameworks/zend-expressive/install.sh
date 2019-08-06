#!/bin/sh

set -e

VERSION="$1"
test -n "$VERSION" && DIR="v${VERSION//\*/x}" || DIR="latest"

rm -rf "$DIR"

composer create-project --no-interaction --prefer-dist --no-dev --no-scripts zendframework/zend-expressive-skeleton "$DIR" "$VERSION"

pushd "$DIR"
composer update --no-interaction
composer require --no-interaction zendframework/zend-expressive-fastroute
composer require --no-interaction zfcampus/zf-development-mode
composer development-disable 

mkdir -p templates/app templates/error templates/layout
composer expressive handler:create -- "App\Handler\HelloHandler"
popd

cp routes.php "$DIR/config/"
cp HelloHandler.php "$DIR/src/App/Handler/"

composer update --no-interaction --working-dir="$DIR"
