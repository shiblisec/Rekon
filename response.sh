#!/bin/bash

mkdir -p headers
mkdir -p responsebody

export CURRENT_PATH=$(pwd)

fetch_resp() {
	echo -e "Scanning: $1"
	NAME=$(echo $1 | cut -d "/" -f 3)
	curl -s -X GET -H "X-Forwarded-For: evil.com" $1 -kLI > "$CURRENT_PATH/headers/$NAME"
	curl -s -X GET -H "X-Forwarded-For: evil.com" -kL $1 > "$CURRENT_PATH/responsebody/$NAME"
}


export -f fetch_resp
## cat $1 | xargs -P 50 -n 1 -I {} bash -c "fetch_resp {}"
cat $1 | xargs -P 50 -I {} bash -c "fetch_resp {}"
