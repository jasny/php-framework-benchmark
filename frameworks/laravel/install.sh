#!/bin/sh

set -e

VERSION="$1"
test -n "$VERSION" && DIR="v${VERSION//\*/x}" || DIR="latest"

rm -rf "$DIR"

composer create-project --no-interaction --prefer-dist laravel/laravel "$DIR" "$VERSION"
composer install --no-dev --working-dir="$DIR"
composer update --no-interaction --no-dev --working-dir="$DIR"

cp .env.prod "$DIR/.env"
cp HelloController.php "$DIR/app/Http/Controllers/"

cp routes.php "$DIR/routes/web.php"
echo '<?php' > "$DIR/routes/api.php"
echo '<?php' > "$DIR/routes/console.php"

chmod ugo+rwX "$DIR/storage" -R

