#!/bin/sh
set -e

get_latest_release()
{
  gh release list --exclude-pre-releases -R $1 -L 1 | cut -f2 -d' ' | sed 's/\s.*$//'
}

mkdir -p /tmp/gh-dl && cd /tmp/gh-dl
gh release download -R neovim/neovim -p "nvim-linux64.tar.gz"
gh release download -R BurntSushi/ripgrep -p  "ripgrep-$(get_latest_release BurntSushi/ripgrep)-x86_64-unknown-linux-musl.tar.gz"
cd - > /dev/null
