#!/bin/bash

mkdir nmapscans

for domain in $(cat $1)
do
	nmap -sC -sV $domain | tee nmapscans/$domain
done
