#!/bin/sh
set -e

apt install zip curl git wget jq python3-pip python3-venv tmux build-essential -y

mkdir -p "$HOME/.local"

printf '⚠️  ADD (OR REPLACE) THIS LINE BELOW TO YOUR ~/.bashrc  ⚠️
export PATH=$PATH:$HOME/.local/bin
\n'
