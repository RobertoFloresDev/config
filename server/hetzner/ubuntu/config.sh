#!/bin/bash
# LOGIN AS ROOT
# ssh root@<ip> -i <key>
useradd -ms /bin/bash <user>
usermod -aG sudo <user>
echo "<user>:<user>" | chpasswd
# echo "<user> ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/<user>
# Set swap (verify first with free)
free -m
fallocate -l 8G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile swap swap defaults 0 0' | tee /etc/fstab > /dev/null

# TODO: review down here
# remove password access and copy the root key to the user
# https://www.cyberciti.biz/faq/how-to-disable-ssh-password-login-on-linux/
mkdir ~/.ssh
sudo cp /root/.ssh/authorized_keys ~/.ssh
sudo chown ack:ack ~/.ssh/authorized_keys
