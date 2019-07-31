#!/bin/sh

for VERSION in v[0-9]* latest; do
  test -d "$VERSION" || continue

  docker build --build-arg VERSION="$VERSION" -t php-framework-benchmark.ice:"$VERSION" .
done

