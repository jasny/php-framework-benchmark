#!/bin/sh

for DIR in v* latest; do
  test -d "$DIR/data/cache" || continue
  chmod ugo+rwX "$DIR/data/cache" -R
done

docker build -t php-framework-benchmark.zend-expressive .

