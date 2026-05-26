#!/bin/bash

# # Install restic locally
sudo apt update
sudo apt install restic -y
sudo restic self-update

# # Restic commands
restic \
-r "sftp:<user>@<box>.your-storagebox.de:./repo" \
-o sftp.args="-p 23 -i ./id_ed25519" \
--password-file ./restic.pass \
# - List snapshots
snapshots
# - List files in snapshot
# ls <snapshot_ID>
# - Restore snapshot into folder
# restore <snapshot_ID> \
# --target ./folder
