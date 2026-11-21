# Devcontainers Ubuntu 24.04 base: ships a non-root "vscode" user with passwordless sudo, plus git.
FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

# Tools for linting and formatting the shell scripts
RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends shellcheck shfmt \
    && rm -rf /var/lib/apt/lists/*
