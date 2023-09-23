#!/bin/sh

architecture=""
case $(uname -m) in
    i386)   architecture="386" ;;
    i686)   architecture="386" ;;
    x86_64) architecture="amd64" ;;
    arm)    dpkg --print-architecture | grep -q "arm64" && architecture="arm64" || architecture="arm" ;;
    aarch64)    dpkg --print-architecture | grep -q "arm64" && architecture="arm64" || architecture="arm" ;;
esac

url=$(curl -s https://api.github.com/repos/cli/cli/releases/latest \
| grep "browser_download_url.*tar.gz" \
| cut -d : -f 2,3 \
| tr -d \" \
| grep "$architecture")

wget -c $url -q -O - | tar -xz --strip-components=1 -C "$HOME/.local"

$HOME/.local/bin/gh auth login
