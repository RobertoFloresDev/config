#!/bin/bash
# Docs http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/service-and-support/Orange-Pi-Zero-3.html
# Download image https://drive.google.com/drive/folders/10zlO-0mMz-fqRQOKAOWX-mQA_UbN_C1n
# IMPORTANT: Use Imager (Rpi) or balenaEtcher to install image into SD Card
ssh orangepi@"<ip>"
# user/pass = orangepi
# comment all (both files) and add https://wiki.debian.org/SourcesList
# sudo nano /etc/apt/sources.list
sudo sed -i '/^deb http/s/^/#/' /etc/apt/sources.list
# sudo nano /etc/apt/sources.list.d/docker.list
sudo sed -i '/^deb \[/s/^/#/' /etc/apt/sources.list.d/docker.list
# add sourceLists
sudo tee -a /etc/apt/sources.list > /dev/null <<'EOF'
deb https://deb.debian.org/debian bookworm main non-free-firmware contrib non-free
deb-src https://deb.debian.org/debian bookworm main non-free-firmware contrib non-free

deb https://security.debian.org/debian-security bookworm-security main non-free-firmware contrib non-free
deb-src https://security.debian.org/debian-security bookworm-security main non-free-firmware contrib non-free

deb https://deb.debian.org/debian bookworm-updates main non-free-firmware contrib non-free
deb-src https://deb.debian.org/debian bookworm-updates main non-free-firmware contrib non-free

deb https://deb.debian.org/debian bookworm-backports main non-free-firmware contrib non-free
deb-src https://deb.debian.org/debian bookworm-backports main non-free-firmware contrib non-free
EOF
# update/upgrade OS
sudo apt update
sudo apt upgrade -y
# change timezone
timedatectl
sudo timedatectl set-timezone America/Mexico_City
timedatectl
# set hostname '<hostname>'
sudo orangepi-config
# Personal > Hostname
# System > Avahi (optional for easy discover the device in network)
exit
# LOGIN AS ROOT
ssh root@"<ip>"
# remove autologin, comment all lines in both files with '#'
# nano /lib/systemd/system/getty@.service.d/override.conf
sed -i '/^ExecStart/s/^/#/' /lib/systemd/system/getty@.service.d/override.conf
sed -i '/^Type/s/^/#/' /lib/systemd/system/getty@.service.d/override.conf
# nano /lib/systemd/system/serial-getty@.service.d/override.conf
sed -i '/^ExecStart/s/^/#/' /lib/systemd/system/serial-getty@.service.d/override.conf
sed -i '/^Type/s/^/#/' /lib/systemd/system/serial-getty@.service.d/override.conf
reboot
ssh root@"<ip>"
# change user name/group
usermod -l <user> orangepi
groupmod -n <user> orangepi
usermod -c <user> <user>
usermod -d /home/<user> -m <user>
# review that user/group is ok
less /etc/passwd
less /etc/group
# clear history
rm /root/.bash_history
exit
# LOGIN AS <user>
ssh <user>@"<ip>"
# change password
passwd
# Install Docker
# https://docs.docker.com/engine/install/debian/
docker ps
systemctl is-enabled docker.service
sudo systemctl enable docker.service
# SSH disable root login
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
# SSH TOTP 2FA
sudo apt-get install libpam-google-authenticator -y
google-authenticator -Ctdf --rate-limit=3 --rate-time=30 --window-size=3
echo 'auth required pam_google_authenticator.so' | sudo tee -a /etc/pam.d/sshd  > /dev/null
sudo sed -i 's/KbdInteractiveAuthentication no/KbdInteractiveAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart ssh
# ADD Tailscale
# Subnet routes and exit nodes may not work correctly.
# See https://tailscale.com/s/ip-forwarding and https://tailscale.com/kb/1019/subnets
curl -fsSL https://tailscale.com/install.sh | sh && sudo tailscale up --auth-key=tskey-auth-kNf... --advertise-exit-node
# Update tailscale
# sudo tailscale update
sudo tailscale set --auto-update
# Set subnet (eg 19.0.0.X and 10.0.0.X)
sudo tailscale set --advertise-routes=19.0.0.0/24,10.0.0.0/24
# See tailscale preferences
sudo tailscale debug prefs
# Tailscale Page (set IPv4, Disable Key Expiry, Edit route settings to set Exit Node and Subnet Routes)
