#!/bin/bash

set -e

echo "Application Path:"
read Apppath
./connectWsadmin.sh -path ./deployment.py
