#!/bin/bash

set -e 

sed  "/WASX7209I/d" ./cellName/cellName.txt > ./cellName/fliterCellName.txt 
