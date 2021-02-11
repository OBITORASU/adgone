# adgone
A bash script to implement a hosts based systemwide adblock.
This script was heavily inspired by the [AdAway](https://github.com/AdAway/AdAway) mobile app, do check it out.

## How it works?
```adgone``` modifies the ```/etc/hosts``` file and redirects all the spammy website domain name resolution to ```0.0.0.0``` (non-routable address), this easily circumvents most of the ads you might come across the internet, on a systemwide level. The script currently uses 4 sources which I have credited below, it fetches the latest content from the sources, modifies/sanitizes the content of the fetched lists and generates a custom list which it then uses to modify ```/etc/hosts```. This means that this script updates its source lists on every subsequent re-run fetching you the latest ad domains to be blocked on the go.

## How to use?
Make sure you have curl installed on your system before using the script.
This script must run with super user privileges to work.

```
curl -O -s https://raw.githubusercontent.com/OBITORASU/adgone/main/adgone.sh 

chmod +x adgone.sh

sudo ./adgone.sh 
```
It is highly recommended that you keep this script running as long as you want to block ads. Pressing `q` in the terminal window where the script is running should terminate the script and restore your hosts file back to its original state. In case you mistakenly closed your terminal windows, to restore your hosts file just do a clean re-run of the script and quit using `q`.

## Sources used:

- [StevenBlack](https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts)
- [Curben](https://curben.gitlab.io/malware-filter/urlhaus-filter-hosts.txt)
- [pgl@yolo.org](https://pgl.yoyo.org/adservers/serverlist.php\?hostformat\=hosts\&showintro\=0\&mimetype\=plaintext)
- [AdAway](https://adaway.org/hosts.txt)

**NOTE**

This method is not fullproof as new ad domains (not present in the source lists) might pop up from time to time.
