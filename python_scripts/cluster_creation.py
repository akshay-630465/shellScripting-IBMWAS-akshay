name=input("Enter the name of the cluster: ")
AdminTask.createCluster("[-clusterConfig [-clusterName {} -preferLocal true]]".format(name))
AdminConfig.save()
print("Suceesfully cluster created")
noOfServers=int(input("Enter no of servers you want to add: "))
for i in range(0,noOfServers):
    serverName=input("Enter the member name: ")
    print("In which node you want to add the member {} from below available nodes: ".format(serverName))
    print(AdminTask.listNodes())
    nodeName=input("Select the node name: ")
    if(i==0):
       print(AdminTask.createClusterMember("[-clusterName {} -memberConfig [-memberNode {} -memberName {} -memberWeight 2 -genUniquePorts true -replicatorEntry false] -firstMember [-templateName default -nodeGroup DefaultNodeGroup -coreGroup DefaultCoreGroup -resourcesScope cluster]]".format(name,nodeName,serverName)))
       AdminConfig.save()
    else:
        print(AdminTask.createClusterMember("[-clusterName {} -memberConfig [-memberNode {} -memberName {} -memberWeight 2 -genUniquePorts true -replicatorEntry false]]".format(name,nodeName,serverName)))  
    	AdminConfig.save()

print("Do you want the all servers on the cluster {}".format(name))
serStarting=input("YES/NO")
if(serStarting.upper() == "YES"):
    





#cell=input("Enter the cell name: ")
#node=input("Enter the node name: ")
#AdminTask.listNodes()

#NameOfServer=input("Enter the name of the Server: ")

#print("AdminTask.createClusterMember('[-clusterName cluster-1 -memberConfig [-memberNode swasNode02 -memberName JVM-999 -memberWeight 2 -genUniquePorts true -replicatorEntry false] -firstMember [-templateName default -nodeGroup DefaultNodeGroup -coreGroup DefaultCoreGroup -resourcesScope cluster]]')")
