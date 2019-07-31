#!/bin/sh

if [ ! `which curl` ]; then
    echo "curl command not found."
    exit 1;
fi

if [ $# -eq 0 ]; then
    TARGETS=`cat frameworks.txt`
else
    TARGETS="${@%/}"
fi

for TARGET in $TARGETS; do
    echo -n "$TARGET "
    source bin/serve.sh start "$TARGET" > /dev/null
    sleep 0.2
    RESULT=`curl --fail --silent http://localhost:8081/hello`

    if [ "$RESULT" == "Hello World!" ] ; then
        echo "✔"
    else
        echo "⨯"

        set -- $TARGETS
        if [ $# -eq 1 ]; then
            echo
            curl -sSi http://localhost:8081/hello
        fi
    fi

    source bin/serve.sh stop "$TARGET" > /dev/null
    sleep 0.2
done

