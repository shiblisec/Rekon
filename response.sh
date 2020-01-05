#!/bin/bash

mkdir headers
mkdir responsebody

CURRENT_PATH=$(pwd)

for x in $(cat $1)
do
        NAME=$(echo $x | awk -F/ '{print $3}')
        y=$(echo $x | awk -F/ '{print $1}'| sed 's/.$//')
        curl -k -X GET -H "X-Forwarded-For: 127.0.0.1" $x -I > "$CURRENT_PATH/headers/$NAME-$y"
        curl -k -s -X GET -H "X-Forwarded-For: 127.0.0.1" -L $x > "$CURRENT_PATH/responsebody/$NAME-$y"
done
