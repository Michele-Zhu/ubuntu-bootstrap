#!/usr/bin/env bash
# Install Google Chrome. Called by bootstrap.sh as the normal user; uses sudo where root is needed.
set -Eeuo pipefail

curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

sudo apt update
sudo apt install -y google-chrome-stable
