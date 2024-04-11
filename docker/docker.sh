#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Function to prepare the environment
setup_environment() {
    echo "Creating a temporary directory for Docker installation..."
    mkdir -p docker-installation-temp && cd docker-installation-temp || exit
}

# System update and upgrade
system_update() {
    echo "Updating and upgrading the system packages..."
    apt update -y && apt upgrade -y
}

# Install Git
install_git() {
    echo "Installing Git..."
    apt install git -y
}

# Download Docker packages
download_docker_packages() {
    echo "Downloading Docker and its dependencies..."
    wget https://download.docker.com/linux/debian/dists/bookworm/pool/stable/arm64/containerd.io_1.6.28-2_arm64.deb \
         https://download.docker.com/linux/debian/dists/bookworm/pool/stable/arm64/docker-ce_26.0.0-1~debian.12~bookworm_arm64.deb \
         https://download.docker.com/linux/debian/dists/bookworm/pool/stable/arm64/docker-ce-cli_26.0.0-1~debian.12~bookworm_arm64.deb \
         https://download.docker.com/linux/debian/dists/bookworm/pool/stable/arm64/docker-buildx-plugin_0.13.1-1~debian.12~bookworm_arm64.deb \
         https://download.docker.com/linux/debian/dists/bookworm/pool/stable/arm64/docker-compose-plugin_2.25.0-1~debian.12~bookworm_arm64.deb \
         https://download.docker.com/linux/debian/dists/bookworm/pool/stable/arm64/docker-ce-rootless-extras_26.0.0-1~debian.12~bookworm_arm64.deb
}

# Make packages executable
make_executable() {
    echo "Making downloaded packages executable..."
    chmod +x ./*.deb
}

# Install Docker packages
install_docker() {
    echo "Installing Docker and its components..."
    dpkg -i ./*.deb
}

# Configure Docker user and group
configure_docker_user() {
    echo "Adding 'docker' group and assigning the current user..."
    groupadd docker || true # Ignore if group already exists
    usermod -aG docker $USER
}

# Restart Docker to apply changes
restart_docker() {
    echo "Restarting Docker service..."
    systemctl restart docker
}

# Test Docker installation
test_docker() {
    echo "Testing Docker installation with 'hello-world' image..."
    docker run hello-world
}

# Clean up installation temporary files
cleanup() {
    echo "Cleaning up temporary files..."
    cd .. && rm -rf ./docker-installation-temp
}

# Fix potential broken installations
fix_broken_install() {
    echo "Fixing broken installations if any..."
    apt --fix-broken install -y
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

# Exiting from super user (if script is run as a sourced script)
# It's safer to remind the user to exit instead of including an exit command here.
echo "Please, manually exit from the super user mode with 'exit' command."
