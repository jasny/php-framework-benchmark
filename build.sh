#!/bin/sh

if [ ! `which docker` ]; then
    echo "docker command not found."
    exit 1;
fi

if [ $# -eq 0 ]; then
    FRAMEWORKS=`awk -F : '{print $1}' < frameworks.txt | sort | uniq`
else
    FRAMEWORKS="${@%/}"
fi

docker build -t php-framework-benchmark .
echo

for FRAMEWORK in $FRAMEWORKS; do
  test -d "frameworks/$FRAMEWORK" || continue

  echo "***** $FRAMEWORK *****"
  pushd "frameworks/$FRAMEWORK" > /dev/null
  source build.sh
  popd > /dev/null
  echo
done

