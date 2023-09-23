#!/bin/sh
set -e

get_latest_release()
{
  gh release list --exclude-pre-releases -R $1 -L 1 | cut -f2 -d' ' | sed 's/\s.*$//'
}

mkdir -p /tmp/gh-dl && cd /tmp/gh-dl
gh release download -R BurntSushi/ripgrep -p  "ripgrep-$(get_latest_release BurntSushi/ripgrep)-arm-unknown-linux-gnueabihf.tar.gz"
cd - > /dev/null
