#!/bin/bash

# - Docs > http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/service-and-support/Orange-Pi-Zero-3.html
# - Download Image > https://drive.google.com/drive/folders/10zlO-0mMz-fqRQOKAOWX-mQA_UbN_C1n
# - IMPORTANT: Use Imager (Rpi) or balenaEtcher to install image into SD Card

# # LOGIN AS ORANGEPI > user/pass = orangepi
# ssh orangepi@<ip>

# # Update SourceList
# - Comment all (both files) and add https://wiki.debian.org/SourcesList
sudo sed -i '/^deb http/s/^/#/' /etc/apt/sources.list
sudo sed -i '/^deb \[/s/^/#/' /etc/apt/sources.list.d/docker.list
# - Add sourceLists
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
# sudo nano /etc/apt/sources.list
# sudo nano /etc/apt/sources.list.d/docker.list

# # Update/Upgrade OS
sudo apt update
sudo apt upgrade -y

# # OS Configs
# - Change timezone
timedatectl
sudo timedatectl set-timezone America/Mexico_City
timedatectl
# - Set hostname '<hostname>'
sudo orangepi-config
# - Personal > Hostname
# - System > Avahi (optional for easy discover the device in network)

exit

# # LOGIN AS ROOT > user/pass = root/orangepi
# ssh root@<ip>

# # Remove autologin
# - Comment all lines in both files with '#'
sed -i '/^ExecStart/s/^/#/' /lib/systemd/system/getty@.service.d/override.conf
sed -i '/^Type/s/^/#/' /lib/systemd/system/getty@.service.d/override.conf
sed -i '/^ExecStart/s/^/#/' /lib/systemd/system/serial-getty@.service.d/override.conf
sed -i '/^Type/s/^/#/' /lib/systemd/system/serial-getty@.service.d/override.conf
# nano /lib/systemd/system/getty@.service.d/override.conf
# nano /lib/systemd/system/serial-getty@.service.d/override.conf

reboot

# # LOGIN AS ROOT > user/pass = root/orangepi
# ssh root@<ip>

# # Change user name/group
usermod -l <user> orangepi
groupmod -n <user> orangepi
usermod -c <user> <user>
usermod -d /home/<user> -m <user>
# - Review that user/group is ok
less /etc/passwd
less /etc/group
# - Clear history
rm /root/.bash_history

exit

# # LOGIN AS <user> > user/pass = <user>/orangepi
# ssh <user>@<ip>

# # Change password if required
passwd

# # Install docker > https://docs.docker.com/engine/install/debian/
# - Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# - Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
# - Verify service is enabled
systemctl is-enabled docker.service
# - If not, enable the service
sudo systemctl enable docker.service
docker ps

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

# # Install tailscale
# - Subnet routes and exit nodes may not work correctly.
# - See https://tailscale.com/s/ip-forwarding and https://tailscale.com/kb/1019/subnets
curl -fsSL https://tailscale.com/install.sh | sh && sudo tailscale up --auth-key=tskey-auth-kNf... --advertise-exit-node
# - Update tailscale
# sudo tailscale update
sudo tailscale set --auto-update
# - Set subnet (eg 19.0.0.X and 10.0.0.X)
sudo tailscale set --advertise-routes=19.0.0.0/24,10.0.0.0/24
# - Set Accept routes (in case you want to accept routes from other devices)
sudo tailscale set --accept-routes
# - See tailscale preferences
sudo tailscale debug prefs
# - Tailscale Page (set IPv4, Disable Key Expiry, Edit route settings to set Exit Node and Subnet Routes)

# - Clear bash history
rm .bash_history
