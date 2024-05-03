#!/bin/bash
#set -x ## for having debug mode 
set -e  ##exit the script execution when an error occurs 


read -p "Enter hostname:" hostname
read -p "Enter profile Type [default,dmgr,managed,management,secureproxy]:" profileType
echo "Already avaliable profiles are "
${WAS_HOME}/bin/manageprofiles.sh -listProfiles
read -p "Enter the  profileName which is not defined :" profileName

read -p "Enable  admin security (Y/N):" security
security=$(echo "$security" | tr '[:upper:]' '[:lower:]')

if [[ "$security" == "y" ]]
then
	read -p "Enter admin username :" adminUserName
	read -p "Enter admin password :" adminPassword
	${WAS_HOME}/bin/manageprofiles.sh -create -profileName "${profileName}" -templatePath ../profileTemplates/${profileType}/ -enableAdminSecurity true -adminUserName "${adminUserName}" -adminPassword "${adminPassword}" -hostName "${hostname}"
	if [ $? == 0 ];
	then
		echo "profile Creation is successfully completed"
	fi
else 
	${WAS_HOME}/bin/manageprofiles.sh -create -profileName "${profileName}" -templatePath ../profileTemplates/${profileType}/ -hostName "${hostname}"
fi
## updating the bash profile with profileName

if [ "${profileType}" == "dmgr" ]; then
    if [ "${DMGR}" != "${profileName}" ]; then
         sed -i "s/export DMGR=.*/export DMGR=${profileName}/" /was9/.bashrc
        . /was9/.bashrc
	. /was9/.bashrc
    else
        echo "export DMGR=${profileName}" >> /was9/.bashrc
        . /was9/.bashrc
	. /was9/.bashrc
    fi
elif [ "${profileType}" == "default" ]; then
    if [ "${APP}" != "${profileName}" ]; then
         sed -i "s/export DMGR=.*/export APP=${profileName}/" /was9/.bashrc
        . /was9/.bashrc
	. /was9/.bashrc
    else
        echo "export APP=${profileName}" >> /was9/.bashrc
        . /was9/.bashrc
	. /was9/.bashrc
    fi
fi
