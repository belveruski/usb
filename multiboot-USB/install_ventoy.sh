#!/bin/bash

# Script to install Ventoy

# Check if the script being run as root
if [[ $EUID -ne 0 ]]; then
    echo "[-] This script must be run as root"
    exit 1
fi

# Ask the user to enter the lastest release of the tools
echo [i] Releases version of Ventoy: https://github.com/ventoy/Ventoy/releases
read -p '[+] Enter the latest version of Ventoy=' ventoy_version
echo [+] Installation of Ventoy...

# Requierements
sudo -E sh -c 'apt-get install -qq -y exfat-fuse exfat-utils < /dev/null > /dev/null'

# Check if the tools is already downloaded in the current directory.
if [ -d  ventoy-$ventoy_version ];
then
    echo "[-] Ventoy is already downloaded."
    exit
else
    # Download the tools from Github
    sudo -E sh -c 'wget -q https://github.com/ventoy/Ventoy/releases/download/v'$ventoy_version'/ventoy-'$ventoy_version'-linux.tar.gz'
    if [ $? -ne 0 ]
    then
        echo "[-] Ventoy $ventoy_version was not installed because this version does not exist."
    else
        tar -xzvf ventoy-$ventoy_version-linux.tar.gz &> /dev/null && rm ventoy-$ventoy_version-linux.tar.gz
        echo [+] Ventoy was installed.
    fi
fi