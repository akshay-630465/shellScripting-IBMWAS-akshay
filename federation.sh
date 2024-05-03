#!/bin/bash

set -e  ## exit the script when there is error in the command
<<<<<<< HEAD
echo "Listing all the avaliable profiles: "
${WAS_HOME}/bin/manageprofiles.sh -listProfiles
read -p "Enter profile Name which you want to fedrate: " name
read -p "Enter hostname: " hostname
read -p "Enter dmgr soap port Number: " soap
read -p "Is Admin security is Enabled [Y/N]: " security
security="${security^^}"
if [[ $security == "Y" ]];then
	
	read -p "Enter Username : " username
	read -p "Enter Admin password: " -s passwd
=======

read -p "Enter profile Name which you want to fedrate: " name
read -p "Enter hostname: " hostname
read -p "Enter dmgr soap port Number: " soap
read "Is Admin security is Enabled [Y/N]: " security
security=$(echo "$security" | tr '[:upper:]' '[:lower:]')
if [[ $"security" == "y" ]];then
	
	read -p "Enter Username : " username
	read -s "Enter Admin password: " passwd
>>>>>>> f24ab0271fc24fe8b65d6b55ab3ee758488ddd6c
	${PROFILES}/${name}/bin/addNode.sh $hostname $soap -username $username -password $passwd
else 
	${PROFILES}/${name}/bin/addNode.sh $hostname $soap
fi
