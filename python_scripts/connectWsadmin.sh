#!/bin/bash

set -e

#echo "Enter hostname"
#read hostname
#echo "Enter soap port:"
#read port
#echo "username:"
#read username
#echo "password"
#read passwd
path=$2
output_file=$4
${WAS_HOME}/bin/wsadmin.sh  -lang jython -conntype SOAP -host localhost -port 8884 -username wasadmin -password sarasu10  -f ${path} 
