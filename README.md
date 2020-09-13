podman-ghidra-server
=====

The NSA software reverse engineering tool, Ghidra, uses a server component for collaboration. This project wraps Ghidra Server in a Podman container for ease of deployment and management.

## Quickstart

1. Run build.sh
2. On SELinux enforced systems run `sudo chcon -Rt container_file_t repos/` or add an entry to your file context db of SELinux.
3. Run deploy.sh
4. Run `addUsers.py UserName` where UserName is your new user to add.
5. Default pw for new user is "changeme"
