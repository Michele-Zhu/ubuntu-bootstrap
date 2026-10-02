#!/usr/bin/env bash

set -euo pipefail

echo "setting up spicetify"

main() {
    # install spotify
    curl -sS https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update && sudo apt-get install spotify-client
    # grant permission
    sudo chmod a+wr /usr/share/spotify
    sudo chmod a+wr /usr/share/spotify/Apps -R
    # Log in in spotify
    echo "In case of a fresh install, open Spotify and log in."
    echo "Leave Spotify open for at least 60 seconds so it can generate the files Spicetify needs."
    echo "Press Enter when you're ready to continue..."
    read -r
    # wait enter code
    # install spicetify
    curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
    # apply patch
    bash -c spicetify backup apply
    echo "setup completed some extensions that you'll want to install:"
    echo "- Bookmark spicetify"
    echo "- shuffle+"
    echo "- adblockify"
    echo "- Trash Bin"
}


main "$@"
