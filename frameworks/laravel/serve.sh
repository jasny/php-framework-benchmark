#!/bin/sh

NAME=$1
VERSION=$2
PORT=$3

if ! test -d "$VERSION"; then
  >&2 echo "Version $VERSION not installed"
  exit 1
fi

docker run -d -p "$PORT":80 --name "$NAME" -v "$PWD/$VERSION":/var/www/app php-framework-benchmark.laravel

docker exec "$NAME" -w /var/www/app composer install --no-dev --no-interaction --optimize --classmap-authoritative
docker exec "$NAME" -w /var/www/app 'php artisan route:cache; php artisan config:cache; php artisan optimize'

