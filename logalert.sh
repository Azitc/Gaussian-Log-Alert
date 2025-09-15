#!/bin/bash
# Gaussian 16 log alert system
logchk=$1
foundwhen=$(date)
#Initial termlink
termlink=0
curllink=$(cat curllink.dat)

#########
# Default options
phonelink=0
debugger=0
#########
# Handle options
while getopts "p:d" option
do
	case $option in
	p ) phonelink=1 ;;
	d ) debugger=1 ;;
	\? ) echo "Invalid option -$option"; exit 1;;
	esac
done
#Shift positional param
shift $(($OPTIND-1))

# This prevent it from infinitely running even when log is empty
if [ -z "$logchk" ]; then
    echo "Log input is empty so program will exit now!"
    return 1
fi


while [ $termlink = 0 ]; do
#Check for termination on last line only
if tail -n 1 $1 | grep -Fq "Normal termination"
then
#Program terminates normallyi
termlink=1
	echo -e '\033[1;32mGaussian Normal Termination Alert\033[m'
	echo "Found at $foundwhen checking process"
	echo -e "\a"
if [ $phonelink = 1 ]; then
echo "Testphonelink = 1"
	curl \
  -H "Title: Gaussian Job Completed" \
  -H "Priority: Default" \
  -H "Tags: white_check_mark" \
  -d "Normal termination of $1 on $(date), the job had had finished gracefully and will exit." \
  $curllink
fi

elif grep -Fq "Error termination" $1
	then
#Error termination
termlink=1
		echo -e '\033[1;91mGaussian Error Termination Alert\033[m'
		echo "Found at $foundwhen checking process"
		echo -e "\a"
	if [ $phonelink = 1 ]; then
curl \
  -H "Title: Error Termination Alert" \
  -H "Priority: Default" \
  -H "Tags: warning,skull" \
  -d "Error termination detected in $1 on $(date), please check the job or restart." \
  $curllink
	fi

else
sleep 60
#Want to loop this over
fi
done

if [ $debugger = 1 ]; then
echo "FOR DEBUGGING termination code : ${termlink}, phonelink: ${phonelink} connected to ${curllink}"
fi
