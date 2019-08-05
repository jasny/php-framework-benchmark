benchmark ()
{
    target="$1"
    url="$2"

    fw="${target%:*}"
    version="${target##*:}"
    test -n "$version" && name="$fw-${version//\*/x}" || name="$fw"

    ab_log="$output_dir/frameworks/$name.ab.log"
    output="$output_dir/frameworks/$name.output"

    # initial request should succeed
    error=`curl -sS "$url" > /dev/null`
    if test $? -ne 0; then
        echo -e "$target\n$error" >> "$error_file"
        echo "---" >> "$error_file"

        return -1;
    fi

    # get rpm
    ab -q -c 10 -t 3 "$url" > "$ab_log"
    rps=`grep "Requests per second:" "$ab_log" | cut -f 7 -d " "`

    # get time
    count=10
    total=0
    i=0
    while test "$i" -lt "$count"; do
        curl -sS "$url?_usage=1" > "$output"
        curtime=`grep "[usage]" "$output" | cut -f 3 -d ':'`
        times="$times $curtime"
        let 'i=i+1'
    done
    time=`php libs/avg_ms.php $times`

    # get memory and file
    memory=`grep "[usage]" "$output" | tail -n 1 | cut -f 2 -d ':'`
    file=`grep "[usage]" "$output" | tail -n 1 | cut -f 4 -d ':'`

    echo "$target|$rps|$memory|$time|$file" >> "$results_file"

    echo "$target" >> "$check_file"
    grep "Document Length:" "$ab_log" >> "$check_file"
    grep "Failed requests:" "$ab_log" >> "$check_file"
    grep 'Hello World!' "$output" >> "$check_file"
    echo "---" >> "$check_file"

    # check errors
    error=''
    x=`grep 'Failed requests:        0' "$ab_log"`
    if [ "$x" = "" ]; then
        tmp=`grep "Failed requests:" "$ab_log"`
        error="$error$tmp"
    fi
    x=`grep 'Hello World!' "$output"`
    if [ "$x" = "" ]; then
        tmp=`cat "$output"`
        error="$error$tmp"
    fi
    if [ "$error" != "" ]; then
        echo -e "$target\n$error" >> "$error_file"
        echo "---" >> "$error_file"

        return -1;
    fi

    return 0;
}
