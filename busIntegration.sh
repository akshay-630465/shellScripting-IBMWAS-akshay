#!/bin/bash
set -e
#JMS resource configuration

#Creating the Bus for integration

read -p "Enter the bus name: " busName

#Without bus security
read -p "Do you want to enable the bus security?(yes/no) " yesNo
yesNo="${yesNo^^}"
if [ $yesNo = "NO" ]
then 
	echo "AdminTask.createSIBus('[-bus $busName -busSecurity false -scriptCompatibility 6.1 ]')" >./jms/busCreation.py

#Enabling the bus security

else
	echo "AdminTask.createSIBus('[-bus $busName -busSecurity true -scriptCompatibility 6.1 ]')" > ./jms/busCreation.py
	echo "AdminTask.getSecurityDomainForResource('[-resourceName SIBus=$busName -getEffectiveDomain false]')" >> ./jms/busCreation.py
	echo "AdminTask.modifySIBus('[-bus $busName -busSecurity true -permittedChains SSL_ENABLED ]')" >> ./jms/busCreation.py
fi
echo "AdminConfig.save()" >> ./jms/busCreation.py
echo "AdminConfig.reset()" >> ./jms/busCreation.py
#echo "print(AdminTask.listSIBuses())" >> ./jms/busCreation.py
#echo "exit" >> busCreation.py
./connectWsadmin.sh -path ./jms/busCreation.py



#Adding bus members to the BUS

read -p "Choose the server or cluster to add to the bus(server/cluster): " busMemberType
#Bus member type is server
busMemberType="${busMemeberType^^}"
if [ "{$busMemberType}" == "SERVER" ]
then
	echo "print(AdminTask.listServers())" > ./jms/clus_ser.py
	./connectWsadmin.sh -path ./jms/clus_ser.py
	read -p "Enter the server name: " serverName
	read -p "Enter the node name on  which the server is created: " nodeName
	echo "AdminTask.addSIBusMember('[-bus $busName -node $nodeName -server $serverName -fileStore -logSize 100 -minPermanentStoreSize 200 -maxPermanentStoreSize 500 -unlimitedPermanentStoreSize false -minTemporaryStoreSize 200 -maxTemporaryStoreSize 500 -unlimitedTemporaryStoreSize false ]')" > ./jms/busMembers.py

else 
#Bus member type is cluster
	echo "print(AdminConfig.list('ServerCluster', AdminConfig.getid( '/Cell:swasCell02/')))" > ./jms/clus_ser.py
	./connectWsadmin.sh -path ./jms/clus_ser.py
	read -p "Enter the name of the cluster: " clusterName
	read -p "Enter the log directory path for file store: " logDirectoryPath
	read -p "Enter the path for permanent store directory: " permanentStoreDirectory
	read -p "Enter the path for temporary store directory: " temporaryStoreDirectory
	echo "AdminTask.addSIBusMember('[-bus $busName -cluster $clusterName -enableAssistance true -policyName HA -fileStore -logSize 100 -logDirectory $logDirectoryPath -minPermanentStoreSize 200 -maxPermanentStoreSize 500 -unlimitedPermanentStoreSize false -permanentStoreDirectory $permanentStoreDirectory -minTemporaryStoreSize 200 -maxTemporaryStoreSize 500 -unlimitedTemporaryStoreSize false -temporaryStoreDirectory $temporaryStoreDirectory ]')" > ./jms/busMembers.py
 
fi

echo "AdminTask.listSIBusMembers('[-bus $busName ]')" >> ./jms/busMembers.py
echo "AdminConfig.save()" >> ./jms/busMembers.py
echo "AdminConfig.reset()" >> ./jms/busMembers.py

./connectWsadmin.sh -path ./jms/busMembers.py
