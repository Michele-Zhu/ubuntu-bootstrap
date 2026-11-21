#!/usr/bin/env bash
# Install pyenv and its Python build dependencies. Called by bootstrap.sh as the normal user; uses sudo where root is needed.
set -Eeuo pipefail

sudo apt install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev libzstd-dev
curl -fsSL https://pyenv.run | bash
~/.pyenv/bin/pyenv init --install
