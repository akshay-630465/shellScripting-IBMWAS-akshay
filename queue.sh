set -e

#Creating queue
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


	
	read -p "Enter the name for the QueueName: " queueName
	read -p "Enter the jndi Name for queue :" jndiName
	read -p "Enter the Bus Name: " busName
	read -p "Enter the destination Queue Name: " destinationName
	echo "AdminTask.createSIBJMSQueue('${scope}', '[-name "${queueName}" -jndiName "${jndiName}" -description -deliveryMode Application -readAhead AsConnection -busName "${busName}" -queueName _SYSTEM.Exception.Destination.CLUSTER-111.000-newbus -scopeToLocalQP false -producerBind false -producerPreferLocal true -gatherMessages false]')" > ./jms/queue.py

	echo "AdminConfig.save()" >> ./jms/queue.py
	echo "AdminConfig.reset()" >> ./jms/queue.py

	./connectWsadmin.sh -path ./jms/queue.py
