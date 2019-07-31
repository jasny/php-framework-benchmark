#!/bin/sh

if [ ! `which composer` ]; then
    echo "composer command not found."
    exit 1;
fi

if [ $# -eq 0 ]; then
    TARGETS=`cat frameworks.txt`
else
    TARGETS="${@%/}"
fi

for TARGET in $TARGETS; do
  FRAMEWORK="${TARGET%:*}"
  VERSION="${TARGET##*:}"

  test -d "frameworks/$FRAMEWORK" || continue

  echo "***** $TARGET *****"
  pushd "frameworks/$FRAMEWORK" > /dev/null
  source install.sh "$VERSION"
  popd > /dev/null
  echo
done

