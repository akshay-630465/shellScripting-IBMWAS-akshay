#!/bin/bash

set -e 

## connect to wsadmin scripting tool 

echo "dmgr soap port:"
read port
echo "username:"
read username 
echo "password:"
read passwd


${WAS_HOME}/bin/wsadmin.sh  -lang jython -conntype SOAP -port ${port} -username ${username} -password ${passwd} -f "/was9/was_scripts/cluster.py"
