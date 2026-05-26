#!/bin/bash

# # LOGIN AS ROOT
# ssh root@<ip> -i <key>

# # Add user
useradd -ms /bin/bash <user>
usermod -aG sudo <user>
echo "<user>:<user>" | chpasswd
# echo "<user> ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/<user>

# # Set SSH for user
mkdir -p /home/<user>/.ssh
cp /root/.ssh/authorized_keys /home/<user>/.ssh
chown <user>:<user> /home/<user>/.ssh/authorized_keys

# # Set swap (verify first with free if required)
free -m
fallocate -l 8G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile swap swap defaults 0 0' | tee /etc/fstab > /dev/null

exit

# # LOGIN AS <user>
# ssh <user>@<ip> -i <key>

# # Follow local ubuntu config.sh for more configuration
