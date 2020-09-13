#!/bin/bash

# Remove (and stop if running) the docker container
podman rm -f ghidra-server 2>/dev/null

# Create the docker container, mounting the repos directory, the timezone file, and mapping server ports
podman create -itd --name ghidra-server -v $(pwd)/repos:/repos -p 13100:13100 -p 13101:13101 -p 13102:13102 localhost/ghidra-server

# Add systemd service to current user and enable it
mkdir -p ~/.config/systemd/user/
podman generate systemd --new --name ghidra-server ghidra-server > ~/.config/systemd/user/container-ghidra-server.service
systemctl --user daemon-reload
systemctl --user enable --now container-ghidra-server.service
