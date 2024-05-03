#!/bin/bash


if [ "DMGR" != "dmgr" ];then
echo "not"
else
echo "yes"
fi

<<<<<<< HEAD
#echo "$0"
#echo "$1"
#read -p "hostname " host
#read -p "port " port
#telnet $host $port
echo $?
#./connectWsadmin.sh -path ./jdbc/datasource.py 
echo $?





read -p "Select the scope(cell/node/cluster):" scopeCF
scopeCF="${scopeCF,,}"
scope=""
cellName=swascell03
if [ $scopeCF == 'cell' ];
then
        scope="Cell="${cellName}""
        echo $scope
fi
if [ $scopeCF == 'cluster' ]
then
        read -p "Enter the cluster name: " clusterName
        scope="Cluster="${clusterName}""
        echo $scope

fi

if [ $scopeCF == "node" ];
then
        read -p "Enter the server name: " serverName
        read -p "Enter the node name: " nodeName
        scope="Node="${nodeName}",Server="${serverName}""
        echo $scope

fi
=======
echo "$0"
echo "$1"
read -p "hostname " host
read -p "port " port
telnet $host $port
echo $?

>>>>>>> f24ab0271fc24fe8b65d6b55ab3ee758488ddd6c
