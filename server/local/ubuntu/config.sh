#!/bin/bash
# LOGIN AS <user>
# ssh <user>@<ip>
# update/upgrade OS
sudo apt update
sudo apt upgrade -y
# change timezone
timedatectl
sudo timedatectl set-timezone America/Mexico_City
timedatectl
# Install Docker
# https://docs.docker.com/engine/install/ubuntu/
systemctl is-enabled docker
# Post Installation Docker
# https://docs.docker.com/engine/install/linux-postinstall/
sudo usermod -aG docker $USER
# SSH disable root login
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
# TODO: Remove password access (STEPS)
# remove password access and copy the root key to the user
# https://www.cyberciti.biz/faq/how-to-disable-ssh-password-login-on-linux/
# SSH TOTP 2FA
sudo apt-get install libpam-google-authenticator -y
google-authenticator -Ctdf --rate-limit=3 --rate-time=30 --window-size=3
echo 'auth required pam_google_authenticator.so' | sudo tee -a /etc/pam.d/sshd  > /dev/null
sudo sed -i 's/KbdInteractiveAuthentication no/KbdInteractiveAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart ssh
# Allow user to reboot or poweroff without password
# sudo echo '$USER ALL=NOPASSWD: /sbin/halt, /sbin/reboot, /sbin/poweroff' >> /etc/sudoers.d/$USER
echo '$USER ALL=NOPASSWD: /sbin/halt, /sbin/reboot, /sbin/poweroff' | sudo tee /etc/sudoers.d/$USER > /dev/null
# WOL
ip address
sudo ethtool <interface>
# Wake-on should support 'g' and should be set to 'g' (verify that also UEFI has WOL Active)
sudo ethtool -s <interface> wol g
# TODO: this WOL approach is not permanent because 'g' gets removed each restart
# Clear bash history
rm .bash_history