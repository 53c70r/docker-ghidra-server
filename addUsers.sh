#!/usr/bin/bash

podman exec -it ghidra-server /ghidra/server/svrAdmin -add $1
