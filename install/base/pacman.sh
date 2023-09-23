#!/bin/sh
set -e

pacman -Sy zip git wget jq python python-pip tmux base-devel neovim ripgrep

mkdir -p "$HOME/.local"

printf '⚠️  ADD (OR REPLACE) THIS LINE BELOW TO YOUR ~/.bashrc  ⚠️
export PATH=$PATH:$HOME/.local/bin
\n'
