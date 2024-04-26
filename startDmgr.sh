#!/bin/bash

set -e 


read -p "Enter the profileName:" name

${PROFILES}/${name}/bin/startManager.sh
