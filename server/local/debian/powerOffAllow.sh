#!/bin/bash
# Allow user to reboot or poweroff without sudo
sudo echo 'ack ALL=NOPASSWD: /sbin/halt, /sbin/reboot, /sbin/poweroff' >> /etc/sudoers.d/ack
# or
echo 'ack ALL=NOPASSWD: /sbin/halt, /sbin/reboot, /sbin/poweroff' > sudo tee /etc/sudoers.d/ack