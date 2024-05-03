#!/bin/bash

set -e

#echo "Enter hostname"
read -p "Enter the hostname: " hostname
read -p "Enter the Dmgr soap port number: " port
#echo "username:"
read -p "Enter the username: " username
#echo "password"
read -p "Enter the password " -s  passwd
path=$2
output_file=$4
echo $4
if [ "${output_file}" != "" ];then
	${WAS_HOME}/bin/wsadmin.sh  -lang jython -conntype SOAP -host "${hostname}" -port "${port}" -username "${username}"   -password "${passwd}"  -f ${path} > ${output_file} 
else 
	${WAS_HOME}/bin/wsadmin.sh  -lang jython -conntype SOAP -host "${hostname}" -port "${port}" -username "${username}"  -password "${passwd}" -f ${path}
fi
	
