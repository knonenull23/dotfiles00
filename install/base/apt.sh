#!/bin/sh
set -e

apt install zip curl git wget jq python3-pip python3-venv tmux build-essential -y

mkdir -p "$HOME/.local"
echo 'export PATH=$PATH:$HOME/.local/bin' >> "$HOME/.bashrc"
