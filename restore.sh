#!/bin/bash

# Define colors and reset
red=`tput setaf 160`
green=`tput setaf 84`
reset=`tput sgr0`

# Check if script is running with root privileges
if [[ $EUID -ne 0 ]]; then
   echo
   echo "${red}[-] This script must be run with root privileges!${reset}" >&2
   exit 1
fi

# Restore hosts file to its original state and remove the cache directory
cd ~/.adgonecache 2>/dev/null
if [[ $? -ne 0 ]]; then
   echo
   echo "${green}[+] Hosts file was not modified by a previous run. Skipping restoration.${reset}"
   exit 0
else
   echo "${green}[+] Cleaning up and restoring hosts file!"
   mv hosts /etc/hosts
   cd ..
   # Remove the cache folder
   rm -r ~/.adgonecache
   sleep 1
   echo
   echo "${green}[+] All done! Thank you for using me.${reset}"
   exit 0
fi
