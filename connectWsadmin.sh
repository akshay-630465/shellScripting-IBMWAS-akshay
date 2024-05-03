#!/bin/bash

set -e

#echo "Enter hostname"
<<<<<<< HEAD
read -p "Enter the hostname: " hostname
read -p "Enter the Dmgr soap port number: " port
#echo "username:"
read -p "Enter the username: " username
#echo "password"
read -p "Enter the password " -s  passwd
=======
#read hostname
#echo "Enter soap port:"
#read port
#echo "username:"
#read username
#echo "password"
#read passwd
>>>>>>> f24ab0271fc24fe8b65d6b55ab3ee758488ddd6c
path=$2
output_file=$4
echo $4
if [ "${output_file}" != "" ];then
<<<<<<< HEAD
	${WAS_HOME}/bin/wsadmin.sh  -lang jython -conntype SOAP -host "${hostname}" -port "${port}" -username "${username}"   -password "${passwd}"  -f ${path} > ${output_file} 
else 
	${WAS_HOME}/bin/wsadmin.sh  -lang jython -conntype SOAP -host "${hostname}" -port "${port}" -username "${username}"  -password "${passwd}" -f ${path}
=======
	${WAS_HOME}/bin/wsadmin.sh  -lang jython -conntype SOAP -host localhost -port 8884 -username wasadmin  -password sarasu10 -f ${path} > ${output_file} 
else 
	${WAS_HOME}/bin/wsadmin.sh  -lang jython -conntype SOAP -host localhost -port 8884 -username wasadmin  -password sarasu10 -f ${path}
>>>>>>> f24ab0271fc24fe8b65d6b55ab3ee758488ddd6c
fi
	
