#!/bin/bash

# Define colors and reset
yellow=`tput setaf 226`
red=`tput setaf 160`
green=`tput setaf 84`
reset=`tput sgr0`

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
   echo "${red}[-] This script must be run as root!" 
   exit 1
fi

# Make a cache dir for storing cached data and cd into it
mkdir ~/.adgonecache 2>/dev/null
cd ~/.adgonecache

# Fetch updated blocklists and mkae a single uniquely sorted blocklist from all of them 
echo "${green}[+] Fetching updates and generating list..."

curl -o steven -s https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts
sed -i -e '1,30d' -e 's/^[ \t]*//' -e '/^#/d' -e '/^$/d' steven   

curl -o curben -s https://curben.gitlab.io/malware-filter/urlhaus-filter-hosts.txt
sed -i -e '1,6d' -e '/^#/d' curben    

curl -o pgl -s https://pgl.yoyo.org/adservers/serverlist.php\?hostformat\=hosts\&showintro\=0\&mimetype\=plaintext
sed -i -e '1,14d' -e 's/127.0.0.1/0.0.0.0/g' pgl      

curl -o adaway -s https://adaway.org/hosts.txt
sed -i -e '1,24d' -e '/^#/d' -e '/^$/d' -e 's/127.0.0.1/0.0.0.0/g' adaway

cat adaway curben pgl steven | sort -u > newhosts

# Backup the original hosts file and sanitize it 
cp /etc/hosts hosts
sed -i '/0.0.0.0/d' hosts

# Modify the hosts file to start blocking ads
echo
echo "${green}[+] Modifying hosts file..."
cat newhosts >> /etc/hosts
sleep 1
echo

# Remove uneeded files for better memory efficiency
rm steven curben pgl adaway newhosts

# Prompt user to quit or keep the script running
echo "${green}[+] Modifying your hosts file. Enjoy an ad free day now!"
echo
echo "${yellow}[!] Please don't close this tab else you might have to re-run the script cleanly to restore your hosts file."
echo "${yellow}[!] You can press q to quit and your hosts file will be resotred."
while read -rs -n 1 key
do
if [[ $key == "q" ]];
then
break;
fi
done

# Restore hosts file to its original state and remove the cache directory
echo "${green}[+] Cleaning up!"
mv hosts /etc/hosts
cd ..
rm -r ~/.adgonecache
sleep 1
echo 
echo "${green}[+] All done! Thank you for using me.${reset}"
exit 0
