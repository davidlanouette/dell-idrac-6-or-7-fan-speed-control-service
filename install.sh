#!/usr/bin/env bash

# NOTE: THIS HASN'T BEEN FULLY TESTED!  Use caution.

# This script will install and configure and the fan-speed-control "service"

# Work on a copy of the file.
cp fan-speed-control.sh fan-speed-control.orig

# Prompt for ip, user and password
read -p "What's the host name or IP address for the iDRAC portal? (the default is 192.168.0.120): " host
read -p "What's the iDRAC login user name? (the default is root): " username
read -s -p "What's the iDRAC login password? (the default is calvin): " password

# Update the script with the prompted values
# NOTE: the macos ver of sed isn't compatible with the linux verson.  You can't debug this on a mac or bsd.
sed -i "s/%%HOST%%/${host}/" fan-speed-control.sh
sed -i "s/%%USER%%/${username}/" fan-speed-control.sh
sed -i "s/%%PASSWORD%%/${password}/" fan-speed-control.sh

# Install prereq's (if not already installed)
sudo dnf install ipmitool lm_sensors

# Run the sensors-detect
echo "You are about to be prompted for the sensors-detect program.  You can just hit enter for all responses (unless you know what you are doing)."
sudo sensors-detect

# Copy the script to the correct location
sudo cp fan-speed-control.sh /usr/local/bin/

# Copy the service def
sudo cp fan-speed-control.service /usr/lib/systemd/system/

# Enable the service, and start it.
sudo systemctl enable /usr/lib/systemd/system/fan-speed-control.service

sudo systemctl start fan-speed-control.service

# Restore the original file when we are done.
cat fan-speed-control.sh
rm fan-speed-control.sh
mv fan-speed-control.orig fan-speed-control.sh
