#!/bin/env bash

sld=''
tld=''
outf='domain_source.txt'

#create usage function which explains script

usage () {
	echo -e "\n subfinder.sh -s -t [ -h ] \n\n Usage:\n -s        second-level domain\n -t        top-level domain(without period)\n -h        get some help\n\n Example: subfinder.sh -s google -t com"
}

#check the options

if [ $# -lt 1 ]; then
	echo "Options are expected"
	usage
	exit 0
fi

#get inputs from user, save it to variable, do actions otherwise

while getopts ":s:t:h" opt; do

	case ${opt} in
		s) sld=${OPTARG}
		;;
		t) tld=${OPTARG}
		;;
		h) usage
		   exit 0
		;;
		?) echo -e "Wrong inputs. Type -h for manual \n"
		   exit 1
		;;
	esac

done

#verify input for arguments

verify_input1(){

	if [ $# -gt 1 ]; then
		echo "ERROR in input $0. Expecting 1 argument but passed $#"
	elif [ $# = 0 ]; then
		echo "No arguments are passed to $0. Type -h for manual"
		exit 1
	fi

	result='OK'

}

verify_input2(){

	if [ $# -gt 1 ]; then
		echo "Error in input $0. Expecting 1 argument but passed $#"
	elif [ $# = 0 ]; then
		echo "No arguments are passed to $0. Type -h for manual"
		exit 1
	fi

	result = 'OK'
}

verify_input1 $sld
verify_input2 $tld

if [ verify_input1 = 'OK' ]; then
	if [ verify_input2 = 'OK' ]; then
		echo -e "target domain: $sld.$tld \n"
		echo -e "Searching for subdomains..."
	fi
fi

echo -e "Loading html of website into $outf\n"

#echo html of website into a file

echo "`curl https://www.$sld.$tld/ -k`" > $outf

echo -e "\n\n Found some subdomains from $sld.$tld :\n"

#run the command

egrep "https://([a-z.]*)?$sld\.$tld" $outf -o | sort -u
	      	


