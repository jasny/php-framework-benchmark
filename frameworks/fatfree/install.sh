#!/bin/sh -e

set -e

VERSION="$1"
test -n "$VERSION" && DIR="v${VERSION//\*/x}" || DIR="latest"

rm -rf "$DIR"

composer create-project --no-interaction --prefer-dist --no-dev bcosca/fatfree "$DIR" "$VERSION"

cp index.php "$DIR"

composer update --no-interaction --working-dir="$DIR"

