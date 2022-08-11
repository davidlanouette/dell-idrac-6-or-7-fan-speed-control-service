#!/usr/bin/env bash

# This script will remove the fan-speed-control "service"

# stop and disable the service
sudo systemctl stop fan-speed-control.service
sudo systemctl disable /usr/lib/systemd/system/fan-speed-control.service

# remove the service def
sudo rm /usr/lib/systemd/system/fan-speed-control.service

# remove the script
sudo rm /usr/local/bin/fan-speed-control.sh

# Install prereq's (if not already installed)
echo "You can remove ipmitool and lm_sensors now, if you want."
echo "sudo dnf remove ipmitool lm_sensors"
