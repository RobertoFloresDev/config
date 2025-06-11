#!/bin/bash
# Docs http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/service-and-support/Orange-Pi-Zero-3.html
# Download image https://drive.google.com/drive/folders/10zlO-0mMz-fqRQOKAOWX-mQA_UbN_C1n
# IMPORTANT: Use Imager (Rpi) to install image into SD Card
ssh orangepi@"<ip>"
# user/pass = orangepi
# comment all (both files) and add https://wiki.debian.org/SourcesList
sudo nano /etc/apt/sources.list
sudo nano /etc/apt/sources.list.d/docker.list
# update/upgrade OS
sudo apt update
sudo apt upgrade
# change timezone
timedatectl
sudo timedatectl set-timezone America/Mexico_City
timedatectl
# set hostname 'ack-<hostname>' and avahi on
sudo orangepi-config
# LOGIN AS ROOT
ssh root@"<ip>"
# remove autologin, comment all lines in both files with '#'
nano /lib/systemd/system/getty@.service.d/override.conf
nano /lib/systemd/system/serial-getty@.service.d/override.conf
# reboot
reboot
# change user name/group
sudo usermod -l ack orangepi
sudo groupmod -n ack orangepi
sudo usermod -d /home/ack -m ack
# review that user/group is ok
less /etc/passwd
less /etc/group
# clear history
rm /root/.bash_history
# LOGIN AS ACK
# change password
passwd
# Install Docker
# https://docs.docker.com/engine/install/debian/
docker ps
sudo systemctl enable docker.service
# ADD Tailscale
# Subnet if require https://tailscale.com/kb/1019/subnets
curl -fsSL https://tailscale.com/install.sh | sh && sudo tailscale up --auth-key=tskey-auth-kNf... --advertise-exit-node
# Set subnet
sudo tailscale set --advertise-routes=192.0.2.0/24,198.51.100.0/24