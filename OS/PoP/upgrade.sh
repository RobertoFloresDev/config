#!/bin/bash

# # Update/Upgrade OS
sudo apt update
# sudo apt upgrade -y

# # Upgrade brave
sudo apt install --only-upgrade brave-browser

# # Upgrade brave origin
sudo apt install --only-upgrade brave-origin-nightly

# # Upgrade chrome
sudo apt install --only-upgrade google-chrome-stable