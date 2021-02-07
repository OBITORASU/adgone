#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root!" 
   exit 1
fi

command -v curl >/dev/null 2>&1
if [[ $? -ne 0 ]]; then
   echo "Please install curl on your system."
   exit 1
fi

echo "Modifying hosts file..."
curl -O https://raw.githubusercontent.com/OBITORASU/adgone/main/hosts -s
cat hosts >> /etc/hosts
echo "Cleaning up..."
rm hosts
echo "All done enjoy an ad free day!"
sleep 1
exit 0

