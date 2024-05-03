
#!/bin/bash

set -e

scope=""
echo "Getting the cellname: "
echo "print(AdminControl.getCell())" > ./cellName/cellName.py 
echo "Provide the details for connecting wsadmin script"
read -p "Enter the hostname " scriptHostName
read -p "Enter the soap port of dmgr: " dmgrSoapPort
read -p "Enter the username: " AdminName
read -p "Enter the password: " -s adminPassword
./updatedConnectWsadmin.sh -path ./cellName/cellName.py -output_file ./cellName/cellName.txt "${scriptHostName}" "${dmgrSoapPort}" "${AdminName}" "${adminPassword}"
./cellName/cellNameFliter.sh
## after getting cellname store , stroing in a variable 
cellName=$(head -n 1 ./cellName/fliterCellName.txt)
echo $cellName




function scope_selection {
	read -p "Select the scope(cell/node/cluster):" scopeCF
	scopeCF="${scopeCF,,}"
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
}
	
db=""
read -p "Do you want to use existing JDBC Provider (Y/N): " userProvider
userProvider="${userProvider,,}"  ##converting to lower case
if [[ ${userProvider} == "n" ]];then
	echo "Creation of JDBC provider"
	read -p "Enter DB type [DB2,ORACLE,sqlserver] :" db
	db="${db^^}"
	if [ $db == "DB2" ];then
		echo "Please select the provider Type from below list: "
		echo "1. DB2 Universal JDBC Driver Provider "
		echo "2. DB2 UDB for iSeries (Toolbox) "
		echo "3. DB2 UDB for iSeries (Native) "
		read -p "Enter the option number eg:1 " providerType
		case $providerType in
			 1)
      				 providerType="DB2 Universal JDBC Driver Provider"
       	 			 ;;
   			 2)
       				 providerType="DB2 UDB for iSeries (Toolbox)"
       				 ;;
   			 3)
       				 providerType="DB2 UDB for iSeries (Native)"
       				 ;;
   			 *)
				echo "Please provide the provider Type"
				;;
		esac
	fi
	echo "You have selected provider type as  ${providerType}"

	if [ $db == "ORACLE" ];then
		 echo "Please select the provider Type from below list: "
		 echo "1. Oracle JDBC Driver "
		 echo "2. Oracle JDBC Driver UCP "
		 read -p "Enter the option number eg:1 " providerType
                 case $providerType in
                         1)
                                 providerType="Oracle JDBC Driver"
                                 ;;
                         2)
                                 providerType= "Oracle JDBC Driver UCP"
                                 ;;      
                         *)
                                echo "Please provide the provider Type"
                                ;;
                esac
        fi
	echo "select Implentation Type"
	echo "1. Connection pool data source "
	echo "2. XA data source "
	read -p "Implementation Type: " implType
	case ${implType} in 
		 1)
                   	implType="Connection pool data source"
                        ;;
                 2)
                 	implType= "XA data source"
                        ;;
		 *)
                        echo "Please provide the implemntation Type"
                        ;;
	esac
	
	read -p "Enter name for provider :" name
	 read -p "path for the drivers:" driver
	db="${db^^}"
	scope_selection 
	echo "AdminTask.createJDBCProvider('[-scope \"${scope}\" -databaseType \"${db}\" -providerType \"${providerType}\" -implementationType \"${implType}\" -name \"${name}\" -classpath \"${driver}/db2jcc.jar ${driver}/db2jcc_license_cu.jar\"]')" > ./jdbc/jdbcScript.py
	#echo "AdminTask.createJDBCProvider('[-scope "${scope}" -databaseType "${db}" -providerType \"${providerType}\" -implementationType \"${implType}\" -name \"${name}\" -classpath \"${driver}"/db2jcc.jar ${driver}/db2jcc_license_cu.jar\" ]')" > ./jdbc/jdbcScript.py
	echo "AdminConfig.save()" >> ./jdbc/jdbcScript.py
	echo "AdminConfig.reset()" >> ./jdbc/jdbcScript.py
	echo "Making connection to scripting tool"
	#./connectWsadmin.sh -path ./jdbc/providers.py
	#echo "JBBC provider is scuessfully created"

fi

#"Connection pool data source" -name "Driver Provider" -description -classpath [${DB2UNIVERSAL_JDBC_DRIVER_PATH}/db2jcc.jar ${UNIVERSAL_JDBC_DRIVER_PATH}/db2jcc_license_cu.jar ${DB2UNIVERSAL_JDBC_DRIVER_PATH}/db2jcc_license_cisuz.jar ] -nativePath [${DB2UNIVERSAL_JDBC_DRIVER_NATIVEPATH} ] ]')
   
######################################################################################################################################################

read -p "Do you want to create j2calias: (Y/N) " j2c
j2c=${j2c^^}
## Taking the input from the user for the creation of j2c alias
if [[ "${j2c}" == "Y" ]];then
	read -p "Name of j2calias: " j2cname
	read -p "Enter the Username: " j2cusername
	read -p "Enter the Password: " j2cpassword
	echo "AdminTask.createAuthDataEntry('[-alias ${j2cname} -user ${j2cusername} -password ${j2cpassword}  ]')" >> ./jdbc/jdbcScript.py
	echo "AdminConfig.save()" >> ./jdbc/jdbcScript.py
	echo "AdminConfig.reset()" >> ./jdbc/jdbcScript.py
	#./connectWsadmin.sh -path ./jdbc/j2cscript.py
	
fi


######################################################################################################################################################

echo "creation of Data Source"

if [ "${userProvider}" == "n" ] || [ "${j2c}" == "Y" ]; then
	./updatedConnectWsadmin.sh -path ./jdbc/jdbcScript.py "${scriptHostName}" "${dmgrSoapPort}" "${AdminName}" "${adminPassword}"  ##creation of providers/j2calias
fi
######################################################################################################################################################


echo "coming -1"

echo "print(AdminConfig.list('JDBCProvider', AdminConfig.getid('/Cell:"${cellName}"/')))" > ./jdbc/providersList.py
./updatedConnectWsadmin.sh -path ./jdbc/providersList.py -output_file ./jdbc/Flitered_providers.txt "${scriptHostName}" "${dmgrSoapPort}" "${AdminName}" "${adminPassword}" 
./jdbc/provider_flitered.sh   ## running the script file for the providers to filter
echo "coming-2"

echo "print(AdminTask.listAuthDataEntries())" > ./jdbc/j2clist.py
echo "connecting for wsadmin script for listing aliases"
./updatedConnectWsadmin.sh -path ./jdbc/j2clist.py -output_file ./jdbc/j2clist.txt "${scriptHostName}" "${dmgrSoapPort}" "${AdminName}" "${adminPassword}"
echo "Listing the alias list "
echo "##################################################################################"
cat ./jdbc/j2clist.txt
echo "##################################################################################"
read -p "paste the name of the alias here : " j2calias


echo "##################################################################################"
cat ./jdbc/Flitered_providers.txt 	##listing the providers (after applying fliter)
echo "##################################################################################"

read -p "select the jdbc provider from above list " jdbcProvider
read -p "Enter the DB Type: [db2,oracle]: " db
read -p "Enter the name of Data source Name: " dataSourceName
read -p "Enter the jndi name: " jndiName
read -p "Enter the database name: " dbName
read -p "Enter the port Number " dbPort
read -p "Enter the hostname of DB " DBHostname

db="${db^^}"
datastore=""
configResource=""
if [ "${db}" == "DB2" ];then
	datastore="com.ibm.websphere.rsadapter.DB2UniversalDataStoreHelper"
	read -p "Enter the driverType: " driverType
	configResource="[databaseName java.lang.String ${dbName}] [driverType java.lang.Integer ${driverType}] [serverName java.lang.String ${DBHostname}] [portNumber java.lang.Integer ${dbPort}]]"

	echo "${configResource}"
	elif [ "{$db}" == "ORACLE" ] ;then
		datastore="com.ibm.websphere.rsadapter.Oracle11gDataStoreHelper"
		read -p "Enter service Name: " serviceName
		configResource="[[URL java.lang.String jdbc:oracle:thin:@"${DBHostname}":"${dbPort}"/"${dbName}":"${serviceName}"]]"
	
fi



echo "AdminTask.createDatasource('"${jdbcProvider}"', '[-name ${dataSourceName} -jndiName ${jndiName} -dataStoreHelperClassName ${datastore} -containerManagedPersistence true -componentManagedAuthenticationAlias ${j2calias} -configureResourceProperties ["${configResource}"]')" > ./jdbc/datasource.py

echo "AdminConfig.save()" >> ./jdbc/datasource.py
	
echo "Configuring the JDBC Data Source"



./updatedConnectWsadmin.sh -path ./jdbc/datasource.py "${scriptHostName}" "${dmgrSoapPort}" "${AdminName}" "${adminPassword}"

if [ $? == 0 ];then
	echo "Successfully jdbc resource is created "
fi 
#echo "AdminTask.createJDBCProvider('[-scope Cell=swasCell02 -databaseType "${db}" -providerType \"${providerType}\" -implementationType \"${implType}\" -name \"${name}\" -classpath \"${driver}\"]')"

#AdminTask.createDatasource('"DB2 Universal JDBC Driver Provider_nn(cells/diskCell01|resources.xml#JDBCProvider_1712744985680)"',"[-name JMSDS -jndiName jndi/dev1 -dataStoreHelperClassName com.ibm.websphere.rsadapter.DB2UniversalDataStoreHelper -containerManagedPersistence true -componentManagedAuthenticationAlias diskCellManager01/db2_auth -configureResourceProperties [[databaseName java.lang.String maxdb76] [driverType java.lang.Integer 4] [serverName java.lang.String 10.0.0.114] [portNumber java.lang.Integer 50000]]]",)

#synchronize  script

#AdminControl.invoke('WebSphere:name=DeploymentManager,process=dmgr,platform=common,node=swasCellManager03,diagnosticProvider=true,version=9.0.5.18,type=DeploymentManager,mbeanIdentifier=DeploymentManager,cell=swasCell03,spec=1.0', 'multiSync', '[false]', '[java.lang.Boolean]')

