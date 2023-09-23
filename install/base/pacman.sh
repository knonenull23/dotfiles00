#!/bin/sh
set -e

apt install zip curl git wget jq python python-pip python-venv tmux base-devel -y

mkdir -p "$HOME/.local"
echo 'export PATH=$PATH:$HOME/.local/bin' >> "$HOME/.bashrc"
