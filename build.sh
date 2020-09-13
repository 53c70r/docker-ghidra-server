#!/bin/bash

# Add folder
mkdir -p repos

# Fix SELinux lable
chcon -Rt container_file_t repos/

# Build the docker image
podman build -t ghidra-server .
