#!/bin/bash
# the script will test for PUT upload method against all the hosts
#usage:
# $ ./puttest.sh hosts.txt

for domain in $(cat $1)
do
 curl -s -o /dev/null -w "URL: %{url_effective} - Response: %{response_code}\n" -X PUT -d "hello world"  "${domain}/evil.txt"
done

