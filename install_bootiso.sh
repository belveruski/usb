#!/bin/bash

# Script to install Bootiso
# Create a USB bootable device from an image file easily and securely.

# Check if the script being run as root
if [[ $EUID -ne 0 ]]; then
   echo "[-] This script must be run as root" 
   exit 1
fi

echo [+] Installation of Bootiso...
# Install requirement
sudo -E sh -c  'apt-get install -qq -y wimtools curl jq < /dev/null > /dev/null'
sudo -E sh -c 'wget -q https://rawgit.com/jsamr/bootiso/latest/bootiso -O /usr/bin/bootiso'
sudo -E sh -c 'chmod +x /usr/bin/bootiso'

# Check if Bootiso is installed
ls /usr/bin/bootiso | grep bootiso &> /dev/null
if [ $? -ne 0 ]
    then 
        echo [-] Bootiso is not installed.
    else
        echo [+] Bootiso is installed.
fi