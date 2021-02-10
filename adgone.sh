#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root!" 
   exit 1
fi

# Make a cache dir for storing cached data and cd into it
mkdir .adgonecache 2>/dev/null
cd .adgonecache

# Fetch updated blocklists and mkae a single uniquely sorted blocklist from all of them 
echo "Fetching updates and generating list"

curl -o steven -s https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts
sed -i -e '1,30d' -e 's/^[ \t]*//' -e '/^#/d' -e '/^$/d' steven   

curl -o curben -s https://curben.gitlab.io/malware-filter/urlhaus-filter-hosts.txt
sed -i -e '1,6d' -e '/^#/d' curben    

curl -o pgl -s https://pgl.yoyo.org/adservers/serverlist.php\?hostformat\=hosts\&showintro\=0\&mimetype\=plaintext
sed -i -e '1,14d' -e 's/127.0.0.1/0.0.0.0/g' pgl      

curl -o adaway -s https://adaway.org/hosts.txt
sed -i -e '1,24d' -e '/^#/d' -e '/^$/d' -e 's/127.0.0.1/0.0.0.0/g' adaway

cat adaway curben pgl steven | sort -u > hosts

# Modify the hosts file to start blocking ads
echo "Modifying hosts file..."
cat hosts >> /etc/hosts

# Remove the cache data folder 
echo "Cleaning up..."
cd ..
rm -r .adgonecache 

echo "All done enjoy an ad free day!"
sleep 1
exit 0

