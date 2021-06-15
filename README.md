# adgone
A bash script to implement a host based systemwide adblock by modifying the `/etc/hosts` file on UNIX like systems.
This script was heavily inspired by the [AdAway](https://github.com/AdAway/AdAway) app, do check it out.

## How it works?
```adgone``` modifies the ```/etc/hosts``` file and redirects all the spammy website domain name resolution to ```0.0.0.0``` (non-routable address), this easily circumvents most of the advertisements you might come across on the internet, on a systemwide level. The script currently uses 4 sources which I have credited duely, it fetches the latest content from the sources, modifies/sanitizes the content of the fetched lists and generates a custom list which it then uses to modify ```/etc/hosts```. This means that this script updates its source lists on every subsequent re-run fetching you the latest ad domains to be blocked on the go. Not to worry, the script also makes a copy of your original hosts file and keeps the backup in a cache, which it later uses to restore your hosts file to its original state.

## How to use?
Make sure you have `curl` installed on your system before using the script. If it is not installed, use 
```
# Debian
apt install curl  

# Arch
pacman -S curl 

# Red Hat
yum install curl
``` 
or any relevant command for your respective package manager to install it.
This script must run with root privileges to work, so please use sudo while running it.

```
# git clone the project
git clone https://github.com/OBITORASU/adgone.git

# cd into scripts folder
cd adgone

# To modify hosts file
sudo ./adgone.sh 

# To restore hosts file back to original after modifications
sudo ./restore.sh
```

## Sources used:

- [StevenBlack](https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts)
- [Curben](https://curben.gitlab.io/malware-filter/urlhaus-filter-hosts.txt)
- [pgl@yolo.org](https://pgl.yoyo.org/adservers/serverlist.php\?hostformat\=hosts\&showintro\=0\&mimetype\=plaintext)
- [AdAway](https://adaway.org/hosts.txt)

**NOTE**

This method is not fullproof as new ad domains (not present in the source lists) might pop up from time to time.
