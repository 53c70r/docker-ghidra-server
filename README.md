podman-ghidra-server
=====

The NSA software reverse engineering tool, Ghidra, uses a server component for collaboration. This project wraps Ghidra Server in a Podman container for ease of deployment and management.

## Quickstart

1. make - build the container
2. make install - deploy podman container and run it
3. make adduser user=admin - Add user "admin" / default pw for new user is "changeme"
