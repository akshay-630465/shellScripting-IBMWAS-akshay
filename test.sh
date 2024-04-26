#!/bin/bash


if [ "DMGR" != "dmgr" ];then
echo "not"
else
echo "yes"
fi

echo "$0"
echo "$1"
read -p "hostname " host
read -p "port " port
telnet $host $port
echo $?

