# Proxmox configurations

## Install Proxmox VE on eMMC
This guide is based on the article: [Install Proxmox VE on eMMC](https://ibug.io/blog/2022/03/install-proxmox-ve-emmc/)

### Steps

- **Enter Debug Mode** > Install Proxmox VE (Debug mode)
- exit first time to get the console
```bash
nano /usr/share/perl5/Proxmox/Sys/Block.pm
```
- add following elsif in the 'unable to get device for partition'
```bash
} elsif ($dev =~ m|^/dev/mmcblk\d+$|) {
  return "${dev}p$partnum";
```

## Change Proxmox IP Address

### Steps
```bash
nano /etc/network/interfaces
```
- change iface to:
```
iface vmbr0 inet dhcp
```
- comment 2 lines for static ip and gateway
- restart networking
```bash
systemctl restart networking
```

## Proxmox Passthrough nvme/ssd to a VM
https://pve.proxmox.com/wiki/Passthrough_Physical_Disk_to_Virtual_Machine_(VM)

## Proxmox start VM delay
https://pve.proxmox.com/pve-docs/pve-admin-guide.html#first_guest_boot_delay