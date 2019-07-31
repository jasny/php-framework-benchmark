#!/bin/sh

TYPE="$1"

if test -f "$TYPE/composer.json"; then
  composer dump-autoload --optimize --classmap-authoritative --no-dev --working-dir="$TYPE"
fi

