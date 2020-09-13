all:
	mkdir -p repos
	chcon -Rt container_file_t repos/
	podman build -t ghidra-server .

install:
	podman create -itd --name ghidra-server -v "$(realpath .)"/repos:/repos -p 13100:13100 -p 13101:13101 -p 13102:13102 localhost/ghidra-server
	mkdir -p ~/.config/systemd/user/
	podman generate systemd --new --name ghidra-server ghidra-server > ~/.config/systemd/user/container-ghidra-server.service
	systemctl --user daemon-reload
	systemctl --user enable --now container-ghidra-server.service

adduser:
		podman exec -it ghidra-server /ghidra/server/svrAdmin -add ${user}

clean:
	rm -rf repos
	systemctl --user disable --now container-ghidra-server.service
	rm -f ~/.config/systemd/user/container-ghidra-server.service
	systemctl --user daemon-reload
