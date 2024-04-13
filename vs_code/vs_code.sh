#!/bin/bash

# https://code.visualstudio.com/docs/setup/linux
#################################################

# Installing the .deb package will automatically install the apt repository and signing key to enable auto-updating using the system's package manager. Alternatively, the repository and key can also be installed manually with the following script:

install_repository() {
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
}

# Then update the package cache and install the package using:
update_install_package() {
    sudo apt install apt-transport-https
    sudo apt update
    sudo apt install code # or code-insiders
}

main() {
    install_repository
    update_install_package
}

main