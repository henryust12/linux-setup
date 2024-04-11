#!/bin/bash

# Update package lists
sudo apt-get update -y

# Define the list of packages to install
packages=(
    fcitx-mozc
    fonts-ipafont-mincho
    fonts-takao-gothic
    fonts-takao-mincho
    ibus-mozc
    mozc-data
    mozc-server
    mozc-utils-gui
    fcitx-config-gtk
    fcitx-frontend-all
    fcitx-frontend-fbterm
    fcitx-frontend-gtk2
    fcitx-frontend-gtk3
    fcitx-frontend-qt5
    fcitx-libs
    fcitx-module-dbus
    fcitx-module-kimpanel
    fcitx-module-lua
    fcitx-module-x11
    fcitx-modules
    fcitx-tools
    fcitx-ui-classic
    gir1.2-fcitx-1.0
    ibus
    ibus-clutter
    ibus-gtk
    ibus-gtk3
    ibus-table
)

# Install each package
sudo apt-get install -y "${packages[@]}"
