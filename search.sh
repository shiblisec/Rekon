#!/bin/bash

BOLD="\e[1m"
NORMAL="\e[0m"
GREEN="\e[32m"
RED="\e[30m"

HELP="
${BOLD}[+]USAGE:${NORMAL} ./search.sh  (OPTIONS)

-j (string) - search in javascript files
-x (string) - search in header files
-e (string) - search in  html files
-n (string) - search nmap scans
-h - help
"

#writing code to check for expressions in html
searchhtml() {
	local WORD="${1}"
	for domain in $(ls responsebody)
	do
		echo -e "\n${BOLD}${GREEN}${domain}${NORMAL}"
		RES=$(cat responsebody/$domain | grep -E "${WORD}")
		if [ $(echo $RES | wc -c) -le 1 ]
		then
			echo -e "${BOLD}${RED}No results found${NORMAL}"
		else
			echo $RES
		fi
	done
}

searchheader() {
	local WORD="${1}"
        for domain in $(ls headers)
        do
		echo -e "\n${BOLD}${GREEN}${domain}${NORMAL}"
                RES=$(cat headers/$domain | grep -E "${WORD}")
		if [ $(echo $RES | wc -c) -le 1 ]
                then
                        echo -e "${BOLD}${RED}No results found${NORMAL}"
                else
                        echo $RES
                fi

        done
}

searchjs() {
	local WORD="${1}"
        for domain in $(ls scriptsresponse)
        do
		for file in $(ls scriptsresponse/$domain)
		do
			echo -e "\n${BOLD}${GREEN}${domain}/${file}${NORMAL}"
                	RES=$(grep --color -E "${WORD}" scriptsresponse/$domain/$file)
                	if [ $(echo $RES | wc -c) -le 1 ]
                	then
                        	echo -e "${BOLD}${RED}No results found${NORMAL}"
                	else
                        	echo $RES
                	fi

        	done
	done
}
searchnmap() {
	local WORD="${1}"
        for domain in $(ls nmapscans)
        do
                echo -e "\n${BOLD}${GREEN}${domain}${NORMAL}"
                RES=$(cat nmapscans/$domain | grep -E "${WORD}")
                if [ $(echo $RES | wc -c) -le 1 ]
                then
                        echo -e "${BOLD}${RED}No results found${NORMAL}"
                else
                        echo $RES
                fi

        done

}

while getopts j:x:e:n:h OPTIONS
do
	case "${OPTIONS}" in
		j) searchjs "${OPTARG}" ;;
		e) searchhtml "${OPTARG}" ;;
		x) searchheader "${OPTARG}" ;;
		n) searchnmap "${OPTARG}" ;;
		h)
			echo -e "${HELP}"
		;;
		*)
			echo "[+] Select a valid option.\n"
			echo -e "${HELP}"
			exit 1
		;;
	esac
done


