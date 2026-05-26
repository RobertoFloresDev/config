#!/bin/bash

# # SSH Access

# - login with password
ssh -p 23 <user>@<box>.your-storagebox.de

# - copy ssh keys
cat ./id_ed25519.pub | ssh -p 23 <user>@<box>.your-storagebox.de install-ssh-key

# - login with key
ssh -p 23 -i ./id_ed25519 <user>@<box>.your-storagebox.de