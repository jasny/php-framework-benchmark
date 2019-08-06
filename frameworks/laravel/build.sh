#!/bin/sh

for DIR in v* latest; do
  test -d "$DIR/storage" || continue
  chmod ugo+rwX "$DIR/storage/*"
done

docker build -t php-framework-benchmark.laravel .
