#!/bin/sh

echo "Update"
sudo apt-get update

echo "Install - dependencies"
sudo apt-get install bash-completion curl nano -y

echo "Install - make"
sudo apt-get install make -y

echo "Install - buld-essential"
sudo apt install build-essential -y

echo "Install - sqlite3"
sudo apt-get install sqlite3 -y

echo "Install - Docker"
# Add Docker's official GPG key:
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
# Install docker
sudo apt-get install docker-ce-cli docker-buildx-plugin docker-compose-plugin -y

echo "Install - Go"
curl https://go.dev/dl/go1.24.4.linux-$(dpkg --print-architecture).tar.gz -o go.tar.gz -L
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go.tar.gz
rm go.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin:~/go/bin' >> ~/.profile

echo "Install - upx"
sudo apt install xz-utils -y
curl https://github.com/upx/upx/releases/download/v5.0.0/upx-5.0.0-$(dpkg --print-architecture)_linux.tar.xz -o upx-linux.tar.xz -L
tar -xf upx-linux.tar.xz
sudo mv upx-5.0.0-$(dpkg --print-architecture)_linux/upx /usr/bin/
rm -rf upx-*

echo "Install - dive"
curl https://github.com/wagoodman/dive/releases/download/v0.13.1/dive_0.13.1_linux_$(dpkg --print-architecture).tar.gz -o dive.tar.gz -L
mkdir dive
tar -C dive -xf dive.tar.gz
sudo mv dive/dive /usr/bin/
rm -rf dive.tar.gz dive

echo "Install - Deno"
sudo apt-get install unzip -y
curl -fsSL https://deno.land/install.sh | sh -s -- -y

echo "Install - NVM (Node Version Manager)"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

echo "Install - Node.js"
nvm install 22