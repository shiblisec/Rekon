#!/bin/bash

for domain in $(cat alive.txt)
do
	curl -i -X PUT -d "hello world"  "${domain}/evil.txt"
done
