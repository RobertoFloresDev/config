#!/bin/sh

sudo apt-get update
sudo apt-get install -y curl
mkdir -p ~/.ackonfig-dev
mkdir -p ~/.ackonfig-dev/bash
curl -sSL https://raw.githubusercontent.com/RobertoFloresDev/config/refs/heads/main/cli/ackonfig-dev/ackonfig-dev.sh -o ~/.ackonfig-dev/ackonfig-dev.sh
curl -sSL https://raw.githubusercontent.com/RobertoFloresDev/config/refs/heads/main/cli/ackonfig-dev/bash/.bashrc -o ~/.ackonfig-dev/bash/.bashrc
chmod +x ~/.ackonfig-dev/ackonfig-dev.sh
if ! grep -Fxq "alias ackonfig-dev='sh ~/.ackonfig-dev/ackonfig-dev.sh'" ~/.bashrc; then
  echo "alias ackonfig-dev='sh ~/.ackonfig-dev/ackonfig-dev.sh'" >> ~/.bashrc
  echo "Bash configuration has been set successfully."
  echo "Please restart your terminal or run 'source ~/.bashrc' to apply the changes."
else
  echo "Bash configuration already exists in .bashrc."
fi
echo "ackonfig-dev has been installed successfully."


# curl -sSL https://raw.githubusercontent.com/RobertoFloresDev/config/refs/heads/main/cli/ackonfig-dev/install.sh | bash