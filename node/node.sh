#!/bin/bash

# System update and upgrade
system_update() {
    echo "Updating and upgrading the system packages..."
    sudo apt-get update -y && sudo apt-get upgrade -y
}

# Install Node.js and npm
install_node() {
    echo "Installing Node.js and npm..."
    # Install Node.js and npm from the repositories
    sudo apt-get install -y nodejs npm
    # Now use 'n' to upgrade to the latest version of Node.js
    sudo npm install -g n
    sudo n stable
}

# Upgrade npm to latest version
upgrade_npm() {
    echo "Upgrading npm to latest version..."
    sudo npm install -g npm@latest
}

configure_npm_user() {
    echo "Adding 'npm' group and assigning the current user..."
    sudo groupadd npm
    sudo usermod -aG npm $USER
}

# Configure npm to use the npm packages without sudo
configure_npm() {
    echo "Configuring npm to use the npm packages without sudo..."
    mkdir ~/.npm-global
    npm config set prefix '~/.npm-global'
    echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.profile
    source ~/.profile
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
    upgrade_npm
    configure_npm_user
    configure_npm    
    check_versions
}

main
