#!/bin/sh

pkg update
pkg install x11-repo
pkg install proot-distro termux-x11-nightly xdotool
proot-distro install archlinux
