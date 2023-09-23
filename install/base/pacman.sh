#!/bin/sh
set -e

pacman -Sy install zip curl git wget jq python python-pip tmux base-devel 

mkdir -p "$HOME/.local"
echo 'export PATH=$PATH:$HOME/.local/bin' >> "$HOME/.bashrc"
