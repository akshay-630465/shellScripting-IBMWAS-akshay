#!/bin/bash

set -e 

## connect to wsadmin scripting tool 

<<<<<<< HEAD

./connectWsadmin.sh -f ./python_scripts/cluster_creation.py

=======
echo "dmgr soap port:"
read port
echo "username:"
read username 
echo "password:"
read passwd


${WAS_HOME}/bin/wsadmin.sh  -lang jython -conntype SOAP -port ${port} -username ${username} -password ${passwd} -f "/was9/was_scripts/cluster.py"
>>>>>>> f24ab0271fc24fe8b65d6b55ab3ee758488ddd6c
