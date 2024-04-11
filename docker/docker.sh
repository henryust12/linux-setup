#!/bin/bash

# Function to prepare the environment
setup_environment() {
    echo "Creating a temporary directory for Docker installation..."
    sudo mkdir -p docker-installation-temp && cd docker-installation-temp || exit
}

# System update and upgrade
system_update() {
    echo "Updating and upgrading the system packages..."
    sudo apt update -y && apt upgrade -y
}

# Install Git
install_git() {
    echo "Installing Git..."
    sudo apt install git -y
}

# Download Docker packages
download_docker_packages() {
    echo "Downloading Docker and its dependencies..."
    sudo wget https://download.docker.com/linux/debian/dists/bookworm/pool/stable/arm64/containerd.io_1.6.28-2_arm64.deb \
         https://download.docker.com/linux/debian/dists/bookworm/pool/stable/arm64/docker-ce_26.0.0-1~debian.12~bookworm_arm64.deb \
         https://download.docker.com/linux/debian/dists/bookworm/pool/stable/arm64/docker-ce-cli_26.0.0-1~debian.12~bookworm_arm64.deb \
         https://download.docker.com/linux/debian/dists/bookworm/pool/stable/arm64/docker-buildx-plugin_0.13.1-1~debian.12~bookworm_arm64.deb \
         https://download.docker.com/linux/debian/dists/bookworm/pool/stable/arm64/docker-compose-plugin_2.25.0-1~debian.12~bookworm_arm64.deb \
         https://download.docker.com/linux/debian/dists/bookworm/pool/stable/arm64/docker-ce-rootless-extras_26.0.0-1~debian.12~bookworm_arm64.deb
}

# Make packages executable
make_executable() {
    echo "Making downloaded packages executable..."
    sudo chmod +x ./*.deb
}

# Install Docker packages
install_docker() {
    echo "Installing Docker and its components..."
    sudo dpkg -i ./*.deb
}

# Configure Docker user and group
configure_docker_user() {
    echo "Adding 'docker' group and assigning the current user..."
    sudo groupadd docker || true # Ignore if group already exists
    sudo usermod -aG docker $USER
}

# Restart Docker to apply changes
restart_docker() {
    echo "Restarting Docker service..."
    sudo systemctl restart docker
}

# Clean up installation temporary files
cleanup() {
    echo "Cleaning up temporary files..."
    cd .. && sudo rm -rf ./docker-installation-temp
}

# Fix potential broken installations
fix_broken_install() {
    echo "Fixing broken installations if any..."
    sudo apt --fix-broken install -y
}

# Test Docker installation
test_docker() {
    echo "Testing Docker installation with 'hello-world' image..."
    docker run hello-world
}

# Main function to orchestrate the steps
main() {
    setup_environment
    system_update
    install_git
    download_docker_packages
    make_executable
    install_docker
    configure_docker_user
    restart_docker
    test_docker
    cleanup
    fix_broken_install
    echo "Docker installation and configuration complete!"
}

# Execute the main function
main
