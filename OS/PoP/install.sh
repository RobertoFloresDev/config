#!/bin/bash

# # Update/Upgrade OS
sudo apt update
sudo apt upgrade -y

# # Install brave > https://brave.com/linux/
sudo apt install curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources
sudo apt update
sudo apt install brave-browser -y

# # Install brave origin > https://brave.com/origin/linux/nightly/
# sudo apt install curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-nightly-archive-keyring.gpg https://brave-browser-apt-nightly.s3.brave.com/brave-browser-nightly-archive-keyring.gpg
sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-nightly.sources https://brave-browser-apt-nightly.s3.brave.com/brave-browser.sources
sudo apt update
sudo apt install brave-origin-nightly -y

# # Install chrome
sudo apt install google-chrome-stable -y

# # Install docker > https://docs.docker.com/engine/install/ubuntu/
# - Add Docker's official GPG key:
# sudo apt update
sudo apt install ca-certificates curl -y
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
# - Install packages
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
# - Post install
sudo usermod -aG docker $USER

# # Install tailscale
curl -fsSL https://tailscale.com/install.sh | sh
# sudo tailscale up --shields-up --accept-routes

# # Install applications
# - VSCode > https://code.visualstudio.com/download
# - RustDesk > https://github.com/rustdesk/rustdesk/releases
# - Obsidian > https://obsidian.md/download
# - Handy STT > https://handy.computer/download