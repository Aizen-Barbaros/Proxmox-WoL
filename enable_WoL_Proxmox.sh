#!/bin/bash

# Install ethtool
sudo apt install ethtool -y

# List network devices
ip addr

# Select network device
echo "Please enter the name of the network device to configure for Wake-on-LAN:"
read device_name

# Check if device supports WOL
ethtool $device_name | grep "Wake-on:"

# Enable WOL on the device
ethtool -s $device_name wol g

# Configure /etc/network/interfaces for WOL
if grep -q "post-up /usr/sbin/ethtool -s $device_name wol g" /etc/network/interfaces; then
  echo "Wake-on-LAN is already configured for $device_name in /etc/network/interfaces"
else
  sed -i "/iface $device_name inet/ a\        post-up /usr/sbin/ethtool -s $device_name wol g" /etc/network/interfaces
  echo "Wake-on-LAN has been configured for $device_name in /etc/network/interfaces"
fi

mac_addr=$(ip addr show $device_name | awk '/ether/ {print $2}')

pvenode config set -wakeonlan $mac_addr
