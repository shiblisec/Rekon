#!/bin/bash

# adding file saving options for nmap

mkdir nmapscans

for domain in $(cat $1)
do
	nmap -sC -sV -oA nmapscans/$domain $domain | tee nmapscans/$domain
done
