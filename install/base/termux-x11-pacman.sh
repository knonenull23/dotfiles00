#!/bin/sh


pacman -Syu
pacman -Sy base-devel git tmux neovim xfce4 nss libxss lsof xdg-utils
useradd -m arch
echo "arch ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
