#!/bin/bash

# Remove repos folder
rm -rf repos

# Remove systemd service
systemctl --user disable --now container-ghidra-server.service
rm -f ~/.config/systemd/user/container-ghidra-server.service
systemctl --user daemon-reload
