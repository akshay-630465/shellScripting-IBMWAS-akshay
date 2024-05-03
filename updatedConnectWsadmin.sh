set -e

#echo "Enter hostname"
#read -p "Enter the hostname: " hostname
#read -p "Enter the Dmgr soap port number: " port
#echo "username:"
#read -p "Enter the username: " username
#echo "password"
#read -p "Enter the password " -s  passwd
echo "Making connection to the wsadmin scripts"
path=$2
output_file=$4
thirdPara=$3

#echo $thirdPara
if [[ "${thirdPara}" == "-output_file" &&  "${output_file}" != "" ]]; then
       ${WAS_HOME}/bin/wsadmin.sh  -lang jython -conntype SOAP -host "$5" -port "$6" -username "$7"   -password "$8"  -f ${path} > ${output_file}
else
        ${WAS_HOME}/bin/wsadmin.sh  -lang jython -conntype SOAP -host "$3" -port "$4" -username "$5"  -password "$6" -f ${path}
fi
