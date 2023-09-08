#!/bin/sh
#
git clone https://aur.archlinux.org/visual-studio-code-bin.git $HOME/visual-studeio-code-bin
cd $HOME/visual-studio-code-bin 
makepkg -si
cd $HOME; rm -rf $HOME/visual-studio-code-bin
