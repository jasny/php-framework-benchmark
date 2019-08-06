#!/bin/sh

for DIR in v* latest; do
  test -d "$DIR/runtime" || continue
  chmod ugo+rwX "$DIR/runtime"
done

docker build -t php-framework-benchmark.yii .
