#!/bin/bash



# Remove the lines containing the word from the file

sed -i "/#builtin_jdbcprovider/d" ./jdbc/Flitered_providers.txt
sed -i "/WASX7209I/d" ./jdbc/Flitered_providers.txt
