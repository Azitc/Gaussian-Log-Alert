#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

while true; do
    read -p "Do you wish to install this program? (y/n): " yn
    case $yn in
        [Yy]* ) 
cp logalert.sh logalert
chmod +x logalert
sed -i "/User specific aliases and functions/a alias lalert=\'${SCRIPT_DIR}/logalert\'" /home/$USER/.bashrc
sed -i "/User specific aliases and functions/a alias logalert=\'${SCRIPT_DIR}/logalert\'" /home/$USER/.bashrc
source /home/$USER/.bashrc;
source linkgen.sh 
break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
