#!/bin/bash

for domain in $(cat $1)
do
	curl -s -o /dev/null -w "URL: %{url_effective} - Response: %{response_code}\n" -X PUT -d "hello world"  "${domain}/evil.txt"
done
