AdminTask.addSIBusMember('[-bus newbus -cluster CLUSTER-111 -enableAssistance true -policyName HA -fileStore -logSize 100 -logDirectory /was9 -minPermanentStoreSize 200 -maxPermanentStoreSize 500 -unlimitedPermanentStoreSize false -permanentStoreDirectory /was9 -minTemporaryStoreSize 200 -maxTemporaryStoreSize 500 -unlimitedTemporaryStoreSize false -temporaryStoreDirectory /was9 ]')
AdminTask.listSIBusMembers('[-bus newbus ]')
AdminConfig.save()
AdminConfig.reset()
