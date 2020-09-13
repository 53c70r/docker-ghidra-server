#!/bin/bash

# Remove (and stop if running) the docker container
podman rm -f ghidra-server 2>/dev/null

# Run the docker container, mounting the repos directory, the timezone file, and mapping server ports
podman run -itd --name ghidra-server -v $(pwd)/repos:/repos -p 13100:13100 -p 13101:13101 -p 13102:13102 localhost/ghidra-server
