#!/bin/sh

termux-change-repo
pkg update
pkg install x11-repo
pkg install proot proot-distro termux-x11-nightly xdotool golang delve
proot-distro install archlinux

mkdir $HOME/workspaces
ln -s $HOME/workspaces $PREFIX/var/lib/proot-distro/installed-rootfs/archlinux/home/arch
