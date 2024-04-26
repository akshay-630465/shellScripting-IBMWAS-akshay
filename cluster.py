AdminTask.createApplicationServer('swasNode02', '[-name JVM-14 -templateName default -genUniquePorts true ]')
AdminConfig.save()
AdminConfig.reset()

print "its working"

for i in range(1,10):
    print(i)

AdminClusterManagement.createClusterWithFirstMember("cluster_name7" ,"APPLICATION_SERVER", "swasNode02", "JVM-14")
AdminConfig.save()
AdminConfig.reset()

AdminClusterManagement.createClusterMember("cluster_name7" , "swasNode02", "JVM-22")
AdminConfig.save()
AdminConfig.reset()

AdminServerManagement.startAllServers("swasNode02")
