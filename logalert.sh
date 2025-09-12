#!/bin/bash
# Gaussian 16 log alert system
logchk=$1
foundwhen=$(date)
#Initial termlink
termlink=0

# This prevent it from infinitely running even when log is empty
if [ -z "$logchk" ]; then
    echo "Log input is empty so program will exit now!"
    return 1
fi


while [ $termlink = 0 ]; do
#Check for termination on last line only
if tail -n 1 $1 | grep -Fq "Normal termination"
then
#Program terminates normally
	echo -e '\033[1;32mGaussian Normal Termination Alert\033[m'
	echo "Found at $foundwhen checking process"
	echo -e "\a"
	termlink=1
elif grep -Fq "Error termination" $1
	then
#Error termination
		echo -e '\033[1;91mGaussian Error Termination Alert\033[m'
		echo "Found at $foundwhen checking process"
		echo -e "\a"
		termlink=1
else
sleep 10
#Want to loop this over
fi
#sleep 10
done
echo "FOR DEBUGGING termination code : $termlink"
