# adgone
A simple bash script to implement a DNS level systemwide adblock.

## How it works?
adgone modifies the ```/etc/hosts``` file and redirects all the spammy website domain name resolution to the localhost, this easily circumvents most of the ads you might come across the internet, on a systemwide level.

## How to use?
Make sure you have curl installed on your system before using the script.
This script must run with super user privileges to work.

```
git clone https://github.com/OBITORASU/adgone.git

cd adgone 

chmod 755 adgone.sh

sudo ./adgone.sh 
```
## Shoutout to the hero

Credits to [StevenBlack](https://github.com/StevenBlack/hosts) for providing the awesome well curated hosts file that this script uses to block ads.
