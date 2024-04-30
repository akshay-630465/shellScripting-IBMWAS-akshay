#!/bin/bash
set -e

#Creating queue connection factory
read -p "Select the scope(cell/node/cluster):" scopeCF
scopeCF="${scopeCF,,}"
scope=""
if [ $scopeCF == 'cell' ];
then 
	read -p "Enter the cell name: " cellName
	scope=""${cellName}"(cells/"${cellName}"|cell.xml)"
	echo $scope
fi
if [ $scopeCF == 'cluster' ]
then
	read -p "Enter the cluster name: " clusterName 
	read -p "Enter the cell name: " cellName
	scope=""${clusterName}"(cells/"${cellName}"/clusters/"${clusterName}"|cluster.xml)"
	echo $scope


fi

if [ $scopeCF == "node" ]; 
then
	read -p "Enter the server name: " serverName
        read -p "Enter the cell name: " cellName
        read -p "Enter the node name: " nodeName
	scope="${serverName}(cells/${cellName}/nodes/${nodeName}/servers/${serverName}|server.xml)"
        echo $scope

fi

	read -p "Enter the connection factory name: " connectionFactoryName
	read -p "Enter the JNDI name: " jndiNameCF
	echo "print(AdminTask.listSIBuses())" > ./jms/listBus.py
	./connectWsadmin.sh  -path ./jms/listBus.py
	read -p "Enter the bus name created during bus integration: " busName
        echo "AdminTask.createSIBJMSConnectionFactory('"${scope}"', '[-type queue -name $connectionFactoryName -jndiName $jndiNameCF -description -category -busName $busName -nonPersistentMapping ExpressNonPersistent -readAhead Default -tempQueueNamePrefix -target -targetType BusMember -targetSignificance Preferred -targetTransportChain -providerEndPoints -connectionProximity Bus -authDataAlias -containerAuthAlias -mappingAlias -shareDataSourceWithCMP false -logMissingTransactionContext false -manageCachedHandles false -xaRecoveryAuthAlias -persistentMapping ReliablePersistent -consumerDoesNotModifyPayloadAfterGet false -producerDoesNotModifyPayloadAfterSet false]')" > ./jms/jmsResource.py
echo "AdminConfig.save()" >> ./jms/jmsResource.py
echo "AdminConfig.reset()" >> ./jms/jmsResource.py

./connectWsadmin.sh  -path ./jms/jmsResource.py





#AdminTask.createSIBJMSConnectionFactory('swasCell02(cells/swasCell02|cell.xml)', '[-type queue -name "${queue_name}" -jndiName "${jndiNameCF}" -description -category -busName ${busName} -nonPersistentMapping ExpressNonPersistent -readAhead Default -tempQueueNamePrefix -target -targetType BusMember -targetSignificance Preferred -targetTransportChain -providerEndPoints -connectionProximity Bus -authDataAlias -containerAuthAlias -mappingAlias -shareDataSourceWithCMP false -logMissingTransactionContext false -manageCachedHandles false -xaRecoveryAuthAlias -persistentMapping ReliablePersistent -consumerDoesNotModifyPayloadAfterGet false -producerDoesNotModifyPayloadAfterSet false]')
