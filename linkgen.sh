#!/bin/bash
#generate your randomized link to ntfy that is hard to guess, the length can be modified
openssl rand -hex 10 > linkext.dat
extlink=$(cat linkext.dat)
echo "ntfy.sh link generated, please update the following link to the app"
echo "ntfy.sh/g16alert_${extlink}"
echo "ntfy.sh/g16alert_${extlink}" > curllink.dat

