useradd -ms /bin/bash ack
usermod -aG sudo ack
echo "ack:ack" | chpasswd
echo "ack ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ack

# remove password access and copy the root key to the user
# https://www.cyberciti.biz/faq/how-to-disable-ssh-password-login-on-linux/

mkdir ~/.ssh
sudo cp /root/.ssh/authorized_keys ~/.ssh
sudo chown ack:ack ~/.ssh/authorized_keys

# Set swap (verify first with free)
free -m
sudo fallocate -l 8G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo su -c "echo '/swapfile swap swap defaults 0 0' >> /etc/fstab"