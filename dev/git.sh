#!/bin/bash

# # Create SSH Keys
# - Create ed25519 key
ssh-keygen -t ed25519 -C "your_email@example.com"
# - Create RSA key (legacy)
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

# # Git Configutations
# - Global Configuration
git config --global user.email "first.last@example.com"
git config --global user.name "First Last"
git config --global core.editor "nano"
# - Local Configuration (for a specific repository)
git config user.email "first.last@example.com"
git config user.name "First Last"
# - List configuration
git config -l

# # git-instaweb - Instantly browse your working repository in gitweb > https://git-scm.com/docs/git-instaweb
sudo apt-get update
sudo apt-get install lighttpd gitweb perl -y
# - Config instaweb
git config --local instaweb.httpd "lighttpd -f"
git config --local instaweb.local false
git config --local instaweb.port 1234
# - Start/Stop instaweb
git instaweb --start
git instaweb --stop