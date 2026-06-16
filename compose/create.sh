#!/bin/bash

# - Create stacks folders
sudo mkdir -p /opt/stacks/compose
sudo mkdir -p /opt/stacks/data
sudo mkdir -p /opt/stacks/track
sudo mkdir -p /opt/stacks/discard
sudo chown -R $USER:$USER /opt/stacks/compose
sudo chown -R $USER:$USER /opt/stacks/data
sudo chown -R $USER:$USER /opt/stacks/track
sudo chown -R $USER:$USER /opt/stacks/discard

# - Create proxy network
docker network create proxy
