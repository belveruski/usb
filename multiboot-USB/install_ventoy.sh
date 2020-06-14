#!/bin/bash

# Script to install Ventoy

# Check if the script being run as root
if [[ $EUID -ne 0 ]]; then
   echo "[-] This script must be run as root" 
   exit 1
fi

# Ask the user to enter the lastest release of the tools
echo [i] Releases version of Ventoy: https://github.com/ventoy/Ventoy/releases
read -p '[+] Enter the platform=' platform
read -p '[+] Enter the latest version of Ventoy=' ventoy_version
echo [+] Installation of Ventoy...

# Requierements
sudo -E sh -c 'apt-get install -qq -y exfat-fuse exfat-utils'

# Check if the tools is already downloaded in the current directory.
if [ -d  ventoy-$ventoy_version ]; 
then 
    echo "[-] Ventoy is already downloaded."
    exit
fi

# Download the tools from Github
if [ $platform = "linux" ]; then
    sudo -E sh -c 'wget -q https://github.com/ventoy/Ventoy/releases/download/v1.0.12/ventoy-'$ventoy_version'-'$platform'.tar.gz'
else
    sudo -E sh -c 'wget -q https://github.com/ventoy/Ventoy/releases/download/v1.0.12/ventoy-'$ventoy_version'-'$platform'.zip'
fi

# Check if the version exist
if [ $? -eq 0 ]; then
    echo [+] This version is available.
else
    echo [-] This version does not exist.
    exit
fi

# Extract the archive and delete it after extraction
tar -xzvf ventoy-$ventoy_version-$platform.tar.gz &> /dev/null && rm ventoy-$ventoy_version-$platform.tar.gz 

echo [+] Ventoy is installed.
