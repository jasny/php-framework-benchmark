#!/bin/sh

NAME=$1
VERSION=$2
PORT=$3

if ! test -d "$VERSION"; then
  >&2 echo "Version $VERSION not installed"
  exit 1
fi

docker run -d -p "$PORT":80 --name "$NAME" -v "$PWD/$VERSION":/var/www/app php-framework-benchmark.laravel

docker exec -w /var/www/app "$NAME" composer install --no-dev --no-interaction --optimize-autoloader --classmap-authoritative 2>&1
docker exec -w /var/www/app "$NAME" php artisan route:cache 2>&1
docker exec -w /var/www/app "$NAME" php artisan config:cache 2>&1
docker exec -w /var/www/app "$NAME" php artisan optimize 2>&1

