#!/bin/bash

set -e  ## exit the script when there is error in the command

read -p "Enter profile Name which you want to fedrate: " name
read -p "Enter hostname: " hostname
read -p "Enter dmgr soap port Number: " soap
read "Is Admin security is Enabled [Y/N]: " security
security=$(echo "$security" | tr '[:upper:]' '[:lower:]')
if [[ $"security" == "y" ]];then
	
	read -p "Enter Username : " username
	read -s "Enter Admin password: " passwd
	${PROFILES}/${name}/bin/addNode.sh $hostname $soap -username $username -password $passwd
else 
	${PROFILES}/${name}/bin/addNode.sh $hostname $soap
fi
