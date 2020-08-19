#!/bin/bash

pkg=balena-etcher-electron

# Check if the script being run as root
if [[ $EUID -ne 0 ]]; then
   echo "[-] This script must be run as root" 
   exit 1
fi

echo [+] Installation of Etcher...
sudo -E sh -c 'echo "deb https://deb.etcher.io stable etcher" | tee /etc/apt/sources.list.d/balena-etcher.list'
sudo -E sh -c 'apt-key adv --keyserver hkps://keyserver.ubuntu.com:443 --recv-keys 379CE192D401AB61'
sudo -E sh -c 'apt-get update -qq'
sudo -E sh -c 'apt-get install -qq -y balena-etcher-electron < /dev/null > /dev/null'

dpkg -s balena-etcher-electron &>/dev/null
if [ $? -ne 0 ]
then
    echo "[-] Etcher was not installed."
else
    echo "[+] Etcher was installed."
fi
