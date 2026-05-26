#!/bin/bash

# - Create stacks folders
sudo mkdir -p /opt/stacks
sudo mkdir -p /opt/stacks-data
sudo chown -R $USER:$USER /opt/stacks
sudo chown -R $USER:$USER /opt/stacks-data

# - Create proxy network
docker network create proxy
