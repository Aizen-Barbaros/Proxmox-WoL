# Proxmox-WoL
A script to enable Wake on LAN on Proxmox

It use the packet "ethtool" for this.

to directly launch the script, you can use this command to the Proxmox node shell : 

```
bash -c "$(wget -qLO - https://github.com/Aizen-Barbaros/Proxmox-WoL/blob/main/enable_WoL_Proxmox.sh)"
```
