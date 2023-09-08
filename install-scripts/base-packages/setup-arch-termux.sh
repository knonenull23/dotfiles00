#!/bin/sh

# proot-distro login archlinux
pacman -Syu
pacman -S base-devel git tmux neovim xfce4
pacman -S nss libxss lsof xdg-utils
useradd -m arch
echo "arch ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
