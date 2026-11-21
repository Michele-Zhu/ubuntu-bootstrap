#!/usr/bin/env bash
# Install Obsidian. Called by bootstrap.sh as the normal user; uses sudo where root is needed.
set -Eeuo pipefail

# download into a temp dir so the .deb doesn't land in the repo
cd "$(mktemp -d)"
URL=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest \
  | grep -o 'https://[^"]*_amd64\.deb' | head -n1)
wget "$URL"
sudo apt install ./obsidian_*_amd64.deb
