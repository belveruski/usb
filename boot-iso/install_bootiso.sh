#!/bin/bash

# Script to install Bootiso

# Check if the script being run as root
if [[ $EUID -ne 0 ]]; then
   echo "[-] This script must be run as root" 
   exit 1
fi

echo [+] Installation of Bootiso...

# Install requirement
sudo -E sh -c  'apt-get install -qq -y wimtools'

# Download and install Bootiso from Github
sudo -E sh -c 'git clone --quiet https://github.com/jsamr/bootiso.git'
cd bootiso && make install &> /dev/null

# Check if Bootiso is installed
ls /usr/local/bin | grep bootiso &> /dev/null
if [ $? -ne 0 ]
    then 
        echo [-] Bootiso is not installed.
    else
        echo [+] Bootiso is installed.
fi