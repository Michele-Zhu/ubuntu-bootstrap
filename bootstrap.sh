#!/usr/bin/env bash
# Exit on error, undefined variables, and failed pipes
set -Eeuo pipefail
trap 'echo; echo "ERROR: bootstrap failed at line $LINENO"; read -rp "Press Enter to close..."' ERR

# --------------------------------------------------
# Configuration
# --------------------------------------------------

SCRIPT_NAME="$(basename "$0")"

SELECTION=false
INSTALL_ALL=false

INSTALL_ESSENTIALS=false
INSTALL_YQ=false
INSTALL_GITLFS=false
INSTALL_GITLAB=false
INSTALL_DOCKER_ENGINE=false
INSTALL_CHROME=false
INSTALL_SUBLIME=false
INSTALL_VSCODE=false
INSTALL_GNOME=false
INSTALL_AUDIO=false
INSTALL_VLC=false
INSTALL_SPICETIFY=false
INSTALL_TEAMS=false
INSTALL_CLAUDE_CODE=false
INSTALL_OBSIDIAN=false

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# --------------------------------------------------
# Help
# --------------------------------------------------

usage() {
    cat <<EOF
Usage:
  $SCRIPT_NAME --all
  $SCRIPT_NAME --selection [OPTIONS]

Main options:
  --all                 Install everything
  --selection           Enable selective installation

Selection options (require --selection):
  --essentials          Install git, curl, wget and gpg
  --yq                  Install yq
  --git-lfs             Install git-lfs
  --glab                Install gitlab cli
  --docker_engine       Install Docker Engine
  --chrome              Install Google Chrome
  --sublime             Install Sublime Text
  --vscode              Install Visual Studio Code
  --gnome-extensions    Install GNOME Browser Connector
  --audio               Install PulseAudio Volume Control
  --vlc                 Install VLC
  --spicetify           Install Spicetify
  --claude_code         Install Claude Code
  --obsidian            Install Obsidian

Other options:
  -h, --help            Display this help

Examples:
  $SCRIPT_NAME --all
  $SCRIPT_NAME --selection --essentials
  $SCRIPT_NAME --selection --chrome --sublime
  $SCRIPT_NAME --selection --docker --chrome --vscode
  $SCRIPT_NAME --selection --essentials --audio --vlc

EOF
}

# --------------------------------------------------
# Argument parsing
# --------------------------------------------------

if [[ $# -eq 0 ]]; then
    usage
    exit 0
fi

for arg in "$@"; do
    case "$arg" in
        --all)
            INSTALL_ALL=true
            ;;
        --selection)
            SELECTION=true
            ;;
        --essentials)
            INSTALL_ESSENTIALS=true
            ;;
        --yq)
            INSTALL_YQ=true
            ;;
        --git-lfs)
            INSTALL_GITLFS=true
            ;;
        --glab)
            INSTALL_GLAB=true
            ;;
        --docker_engine)
            INSTALL_DOCKER_ENGINE=true
            ;;
        --chrome)
            INSTALL_CHROME=true
            ;;
        --sublime)
            INSTALL_SUBLIME=true
            ;;
        --vscode)
            INSTALL_VSCODE=true
            ;;
        --gnome-extensions)
            INSTALL_GNOME=true
            ;;
        --audio)
            INSTALL_AUDIO=true
            ;;
        --vlc)
            INSTALL_VLC=true
            ;;
        --spicetify)
            INSTALL_SPICETIFY=true
            ;;
        --teams)
            INSTALL_TEAMS=true
            ;;
        --claude_code)
            INSTALL_CLAUDE_CODE=true
            ;;
        --obsidian)
            INSTALL_OBSIDIAN=true
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "ERROR: Unknown option: $arg"
            usage
            exit 1
            ;;
    esac
done

# --------------------------------------------------
# Validate arguments
# --------------------------------------------------

if [[ "$INSTALL_ALL" == true && "$SELECTION" == true ]]; then
    echo "ERROR: --all and --selection cannot be used together."
    exit 1
fi

if [[ "$INSTALL_ALL" == true ]]; then
    INSTALL_ESSENTIALS=true
    INSTALL_YQ=true
    INSTALL_GITLFS=true
    INSTALL_GLAB=true
    INSTALL_DOCKER=true
    INSTALL_CHROME=true
    INSTALL_SUBLIME=true
    INSTALL_VSCODE=true
    INSTALL_GNOME=true
    INSTALL_AUDIO=true
    INSTALL_VLC=true
    INSTALL_SPICETIFY=true
    INSTALL_TEAMS=true
    INSTALL_CLAUDE=true
    INSTALL_OBSIDIAN=true
fi

if [[ "$SELECTION" == false && "$INSTALL_ALL" == false ]]; then
    echo "ERROR: You must specify --all or --selection."
    usage
    exit 1
fi

if [[ "$SELECTION" == true ]] &&
   [[ "$INSTALL_ESSENTIALS" == false &&
      "$INSTALL_YQ" == false &&
      "$INSTALL_GITLFS" == false &&
      "$INSTALL_GLAB" == false &&
      "$INSTALL_DOCKER" == false &&
      "$INSTALL_CHROME" == false &&
      "$INSTALL_SUBLIME" == false &&
      "$INSTALL_VSCODE" == false &&
      "$INSTALL_GNOME" == false &&
      "$INSTALL_AUDIO" == false &&
      "$INSTALL_SPICETIFY" == false &&
      "$INSTALL_VLC" == false &&
      "$INSTALL_TEAMS" == false &&
      "$INSTALL_CLAUDE" == false &&
      "$INSTALL_OBSIDIAN" == false ]]; then
    echo "ERROR: Select at least one component."
    usage
    exit 1
fi

# --------------------------------------------------
# Installation functions
# --------------------------------------------------

echo "Updating system packages..."
sudo apt-get update
sudo apt-get upgrade -y

install_essentials() {
    echo "Installing essentials..."
    sudo apt-get install -y git curl wget gpg
}

# not tested yet
install_yq(){
    echo "Installing yq"
    wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq &&\
    chmod +x /usr/local/bin/yq
}

# not tested yet
install_gitlfs(){
    echo "Installing git-lfs"
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
}

# not tested yet
install_glab() {
    echo "Installing gitlab"
    apt install glab
}

install_chrome() {
    echo "Installing Google Chrome..."
    curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

    apt update
    apt install google-chrome-stable
}

install_gnome_extensions(){
    echo "Installing gnome-browser-connector"
    sudo apt install gnome-browser-connector
}

install_sublime() {
    echo "Installing sublime text"
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo tee /etc/apt/keyrings/sublimehq-pub.asc > /dev/null
    echo -e 'Types: deb\nURIs: https://download.sublimetext.com/\nSuites: apt/stable/\nSigned-By: /etc/apt/keyrings/sublimehq-pub.asc' | sudo tee /etc/apt/sources.list.d/sublime-text.sources
    sudo apt update
    sudo apt install -y sublime-text
}

install_vscode() {
    echo "Installing vscode"
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
}

install_audio(){
    echo "Installing PulseAudio Volume Control..."
    sudo apt install -y pavucontrol
}

install_vlc() {
    echo "Installing VLC..."
    sudo apt-get install -y vlc
}

install_docker_engine(){
    echo "Installing docker engine"
    if [[ ! -f "$SCRIPT_DIR/docker-install.sh" ]]; then
        echo "ERROR: docker-install.sh not found!"
        exit 1
    fi

    bash "$SCRIPT_DIR/docker-install.sh"
}

install_spicetify(){
    echo "Installing spotify and spicetify"
    if [[ ! -f "$SCRIPT_DIR/spicetify-install.sh" ]]; then
        echo "ERROR: spicetify-install.sh not found!"
        exit 1
    fi

    bash "$SCRIPT_DIR/spicetify-install.sh"
}

install_teams(){
    snap install teams-for-linux
}

install_claude_code(){
    curl -fsSL https://claude.ai/install.sh | bash
}

#install_claude_desktop(){
    # Download signing key and verify with gpg
    # apt install curl gnupg
    # curl -fsSLo /usr/share/keyrings/claude-desktop-archive-keyring.asc https://downloads.claude.ai/claude-desktop/key.asc
    # echo "deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/claude-desktop-archive-keyring.asc] https://downloads.claude.ai/claude-desktop/apt/stable stable main" | tee /etc/apt/sources.list.d/claude-desktop.list
    # sudo apt update && sudo apt install claude-desktop
#}

install_obsidian(){
    cd SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    URL=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest \
      | grep -o 'https://[^"]*_amd64\.deb' | head -n1)
    wget "$URL"
    apt install ./obsidian_*_amd64.deb
}

# --------------------------------------------------
# Execute selected installations
# --------------------------------------------------

[[ "$INSTALL_ESSENTIALS" == true ]] && install_essentials
[[ "$INSTALL_YQ" == true ]] && install_yq
[[ "$INSTALL_GITLFS" == true ]] && install_gitlfs
[[ "$INSTALL_GLAB" == true ]] && install_glab
[[ "$INSTALL_CHROME" == true ]] && install_chrome
[[ "$INSTALL_GNOME" == true ]] && install_gnome_extensions
[[ "$INSTALL_SUBLIME" == true ]] && install_sublime
[[ "$INSTALL_VSCODE" == true ]] && install_vscode
[[ "$INSTALL_AUDIO" == true ]] && install_audio
[[ "$INSTALL_VLC" == true ]] && install_vlc
[[ "$INSTALL_DOCKER_ENGINE" == true ]] && install_docker_engine
[[ "$INSTALL_TEAMS" == true ]] && install_teams
[[ "$INSTALL_CLAUDE_CODE" == true ]] && install_claude_code
[[ "$INSTALL_OBSIDIAN" == true ]] && install_obsidian

# --------------------------------------------------
# Remove obsolete packages
# --------------------------------------------------
apt autoremove -y

# --------------------------------------------------
# Finished
# --------------------------------------------------

echo
echo "========================================"
echo " Ubuntu setup completed successfully!"
echo " You may need to clean up ~/Downloads folder"
echo "========================================"
