#!/bin/bash
# Fix package manager issues on PoP!_OS
# https://support.system76.com/articles/package-manager-pop/
sudo apt clean
sudo apt update
sudo dpkg --configure -a
sudo apt install -f
sudo apt full-upgrade
sudo apt autoremove --purge