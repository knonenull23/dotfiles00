#!/bin/sh
set -e

architecture=""
case $(uname -m) in
    x86_64) architecture="amd64" ;;
    arm64)    dpkg --print-architecture | grep -q "[arm64 | aarch64]" && architecture="arm64" || architecture="arm" ;;
    aarch64)  dpkg --print-architecture | grep -q "[arm64 | aarch64]" && architecture="arm64" || architecture="arm" ;;
esac

echo $architecture

printf "Checking latest Go version...\n";
LATEST_GO_VERSION="$(curl --silent https://go.dev/VERSION?m=text | head -n 1)";
LATEST_GO_DOWNLOAD_URL="https://go.dev/dl/${LATEST_GO_VERSION}.linux-${architecture}.tar.gz" 

printf "cd to home ($USER) directory \n"
cd $HOME

printf "Downloading ${LATEST_GO_DOWNLOAD_URL}\n\n";
curl -o go.tar.gz -L --progress-bar $LATEST_GO_DOWNLOAD_URL 

printf "Extracting file...\n"
tar -xf go.tar.gz
rm go.tar.gz

echo 'export GOROOT="$HOME/go"' >> "$HOME/.bashrc"
echo 'export GOPATH="$HOME/go/packages"' >> "$HOME/.bashrc"
echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> "$HOME/.bashrc"

printf '⚠️  ADD (OR REPLACE) THIS LINE BELOW TO YOUR ~/.bashrc  ⚠️

export GOROOT="$HOME/go"
export GOPATH="$HOME/go/packages"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
\n'

printf "You are ready to Go!";
