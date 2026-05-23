#!/bin/bash

# # Git Configutations
# - Global Configuration
git config --global user.email "first.last@example.com"
git config --global user.name "First Last"
git config --global core.editor "nano"
# - Local Configuration (for a specific repository)
git config user.email "first.last@example.com"
git config user.name "First Last"
# - Lisc configuration
git config -l

# # Create SSH Keys
# - Create ed25519 key
ssh-keygen -t ed25519 -C "your_email@example.com"
# - Create RSA key (legacy)
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"