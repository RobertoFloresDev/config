#!/bin/bash

mkdir -p ~/.ssh/sockets
chmod 700 ~/.ssh/sockets

# - Keep session active for after disconnection 10 min
tee ~/.ssh/config <<EOF
Host *
    ControlMaster auto
    ControlPath ~/.ssh/sockets/%r@%h-%p
    ControlPersist 10m
EOF

# - Check if a connection is active
# ssh -O check <hostname>

# - List active connections on your system
# ls ~/.ssh/sockets

# - Stop a connection
# ssh -O exit <hostname>