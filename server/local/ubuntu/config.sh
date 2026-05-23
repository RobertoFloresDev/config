#!/bin/bash

# # LOGIN AS <user>
# ssh <user>@<ip>

# # Update/Upgrade OS
sudo apt update
sudo apt upgrade -y

# # OS Configs
# - Change timezone
timedatectl
sudo timedatectl set-timezone America/Mexico_City
timedatectl

# Install Docker > https://docs.docker.com/engine/install/ubuntu/
# - Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# - Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
systemctl is-enabled docker
# - Post Installation Docker > https://docs.docker.com/engine/install/linux-postinstall/
sudo usermod -aG docker $USER

# # SSH Configs 
# - Disable root login
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
# - TODO: remove password access / copy users root key > https://www.cyberciti.biz/faq/how-to-disable-ssh-password-login-on-linux/
# - TOTP 2FA
sudo apt-get install libpam-google-authenticator -y
google-authenticator -Ctdf --rate-limit=3 --rate-time=30 --window-size=3
echo 'auth required pam_google_authenticator.so' | sudo tee -a /etc/pam.d/sshd  > /dev/null
sudo sed -i 's/KbdInteractiveAuthentication no/KbdInteractiveAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart ssh

# # Allow user to reboot or poweroff without password
# sudo echo '$USER ALL=NOPASSWD: /sbin/halt, /sbin/reboot, /sbin/poweroff' >> /etc/sudoers.d/$USER
echo '$USER ALL=NOPASSWD: /sbin/halt, /sbin/reboot, /sbin/poweroff' | sudo tee /etc/sudoers.d/$USER > /dev/null

# # WOL (Wake On LAN)
ip address
sudo ethtool <interface>
# - Wake-on should support 'g' and should be set to 'g' (verify that also UEFI has WOL Active)
sudo ethtool -s <interface> wol g
# - TODO: this WOL approach is not permanent because 'g' gets removed each restart

# - Clear bash history
rm .bash_history
