#!/usr/bin/env bash
# Exit if it fails
set -euo pipefail
trap 'echo; echo "ERROR: bootstrap failed at line $LINENO"; read -rp "Press Enter to close..."' ERR

echo "setting up things for my new Linux (Ubuntu) system"

sudo apt update
sudo apt upgrade -y

# Installing essentials
sudo apt install -y \
    git \
    curl
    
sudo apt install -y wget gpg 

# google chrome
sudo apt install google-chrome-stable 
    
# gnome-extensions
sudo apt install gnome-browser-connector

# Sublime text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo tee /etc/apt/keyrings/sublimehq-pub.asc > /dev/null
echo -e 'Types: deb\nURIs: https://download.sublimetext.com/\nSuites: apt/stable/\nSigned-By: /etc/apt/keyrings/sublimehq-pub.asc' | sudo tee /etc/apt/sources.list.d/sublime-text.sources
sudo apt update
sudo apt install -y sublime-text

# vscode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
    | gpg --dearmor \
    | sudo tee /usr/share/keyrings/microsoft.gpg > /dev/null

sudo tee /etc/apt/sources.list.d/vscode.sources > /dev/null <<'EOF'
Types: deb
URIs: https://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: amd64,arm64,armhf
Signed-By: /usr/share/keyrings/microsoft.gpg
EOF

sudo apt-get update
sudo apt-get install -y code

# PulseAudio Volume Control
sudo apt install -y pavucontrol

# VLC
sudo apt install -y vlc

# Docker-Engine, also do this manually

    
# pyenv
# For now do it manually since you have to setup the shells
# curl https://pyenv.run | bash