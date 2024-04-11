#!/bin/bash

# System update and upgrade
system_update() {
    echo "Updating and upgrading the system packages..."
    sudo apt-get update -y && sudo apt-get upgrade -y
}

# Install Node.js and npm
install_node() {
    echo "Installing Node.js and npm..."
    sudo apt-get install -y nodejs npm
}

# Configure npm to use the npm packages without sudo
configure_npm() {
    echo "Configuring npm to use the npm packages without sudo..."
    mkdir ~/.npm-global
    npm config set prefix '~/.npm-global'
    echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.profile
    source ~/.profile
}

# Upgrade npm to latest version
upgrade_npm() {
    echo "Upgrade npm to latest version..."
    sudo npm install -g n
    sudo n latest
}

# Check Node.js and npm versions
check_versions() {
    echo "Checking Node.js and npm versions..."
    node -v
    npm -v
}

# Main function
main() {
    system_update
    install_node
    configure_npm
    upgrade_npm
    check_versions
}

main
