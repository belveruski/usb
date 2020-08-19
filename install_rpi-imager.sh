#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# Check if the script being run as root
if [[ $EUID -ne 0 ]]; then
    echo '[-] This script must be run as root'
    exit 1
fi

echo '[+] Installation of Raspberry Pi Imager...'
echo '[i] Releases version of Raspberry Pi Imager: https://github.com/raspberrypi/rpi-imager/releases'
read -p '[+] Enter the latest version of Raspberry Pi Imager=' rpiimager_version
sudo -E sh -c "wget -q https://github.com/raspberrypi/rpi-imager/releases/download/v$rpiimager_version/rpi-imager_'$rpiimager_version'_amd64.deb"
if [ $? -ne 0 ]
then
    echo "[-] Raspberry Pi Imager $rpiimager_version was not installed because this version does not exist."
else
    sudo -E sh -c 'apt-get install -y -qq ./rpi-imager_'$rpiimager_version'_amd64.deb < /dev/null > /dev/null'
    rm 'rpi-imager_'$rpiimager_version'_amd64.deb'
    dpkg -s  rpi-imager &>/dev/null
    if [ $? -ne 0 ]
    then
        echo '[-] Raspberry Pi Imager was not installed.'
    else
        echo '[+] Raspberry Pi Imager was installed.'
    fi
fi