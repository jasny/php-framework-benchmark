#!/bin/sh

URL="http://127.0.0.1:8081/hello"

if [ $# -eq 0 ]; then
    export TARGETS=`cat frameworks.txt`
else
    export TARGETS="${@%/}"
fi

output_dir="output/$VARIANT"
results_file="$output_dir/results.log"
check_file="$output_dir/check.log"
error_file="$output_dir/error.log"

mkdir -p "$output_dir" "$output_dir/frameworks"
rm -f "$results_file" "$check_file" "$error_file" "$output_dir"/frameworks/*
touch "$error_file"

source libs/benchmark_function.sh

for TARGET in $TARGETS; do
    FRAMEWORK="${TARGET%:*}"

    [ -d "frameworks/$FRAMEWORK" ] || continue

    echo -n "$TARGET "
    source serve.sh start "$TARGET" > /dev/null
    benchmark "$TARGET" "$URL"
    test $? -eq 0 && echo "done" || echo "failed"
    source serve.sh stop "$TARGET" > /dev/null
done

cat "$error_file"

php libs/show_results_table.php

