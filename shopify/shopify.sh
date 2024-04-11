#!/bin/bash

# Update dan upgrade package
update_package() {
    echo "Mengupdate dan mengupgrade package..."
    sudo apt update -y && sudo apt upgrade -y
}

# Install curl, gcc, g++, make
install_curl_gcc_gpp_make() {
    echo "Menginstall curl, gcc, g++, dan make..."
    sudo apt install -y curl gcc g++ make
}

# Install Ruby full dan Ruby development environment
Instalasi_ruby() {
    echo "Menginstall Ruby full dan Ruby development environment..."
    sudo apt install -y ruby-full ruby-dev
}

# Install git if not installed
install_git() {
    if ! [ -x "$(command -v git)" ]; then
        echo "Menginstall git..."
        sudo apt install -y git
    else
        echo "Git sudah terinstall."
    fi
}

# Install Bundler
install_bundler() {
    echo "Menginstall Bundler..."
    sudo gem install bundler
}

# Install Shopify CLI dan Shopify Theme
install_shopify_cli_theme() {
    echo "Menginstall Shopify CLI dan Shopify Theme..."
    npm install -g @shopify/cli @shopify/theme
}

# addgroup shopify
addgroup_shopify() {
    echo "Menambahkan grup shopify..."
    sudo groupadd shopify
    sudo usermod -aG shopify $USER
}

# Cek versi Shopify
echo "Mengecek versi Shopify..."
shopify version

echo "Instalasi selesai."
echo "Reboot sistem jika diperlukan."

# Main function
main() {
    update_package
    install_curl_gcc_gpp_make
    Instalasi_ruby
    install_git
    install_bundler
    install_shopify_cli_theme
    addgroup_shopify
}

main
