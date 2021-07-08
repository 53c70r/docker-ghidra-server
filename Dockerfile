FROM openjdk:11-jdk

# Install necessary packages: wget, unzip, and ed (used by ghidraSvr script)
RUN apt update && apt upgrade -y && apt install -y wget unzip ed && rm -rf /var/lib/apt/lists/*

# Download Ghidra, verify checksum, extract to /ghidra, delete zip
WORKDIR /tmp
RUN wget -q https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.0_build/ghidra_10.0_PUBLIC_20210621.zip -O ghidra.zip && \
	echo 'aaf84d14fb059beda10de9056e013186601962b6f87cd31161aaac57698a0f11 ghidra.zip' | sha256sum -c
RUN unzip -q ghidra.zip && mv ghidra_9.2.2_PUBLIC /ghidra && rm ghidra.zip

# Setup directory structure
WORKDIR /repos
WORKDIR /ghidra

# Set the repositories dir to /repos, the account name to root, and add
# the -u parameter, which means users are prompted for their usernames.
RUN sed -i \
	-e 's/^ghidra\.repositories\.dir=.*$/ghidra.repositories.dir=\/repos/g' \
	-e 's/^wrapper\.app\.parameter\.2=/wrapper.app.parameter.4=/g' \
	-e 's/^wrapper\.app\.parameter\.1=-a0$/wrapper.app.parameter.2=-a0/g' \
	server/server.conf && \
	echo 'wrapper.app.account=root' >> server/server.conf && \
	echo 'wrapper.app.parameter.3=-u' >> server/server.conf && \
	echo 'wrapper.app.parameter.1=-ip0.0.0.0' >> server/server.conf
	# -e 's/^wrapper\.console\.loglevel=INFO$/wrapper.console.loglevel=DEBUG/g' \
	# -e 's/^#wrapper\.debug=.*$/wrapper.debug=true/g' \
	# -e 's/^wrapper\.logfile\.loglevel=.*$/wrapper.logfile.loglevel=DEBUG/g' \

VOLUME /repos

# Actually start Ghidra server
CMD ["/ghidra/server/ghidraSvr", "console"]
