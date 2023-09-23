#!/bin/sh
set -e

mkdir -p /tmp/curl-dl && cd /tmp/curl-dl
curl -L http://mirror.archlinuxarm.org/aarch64/extra/neovim-0.9.2-1-aarch64.pkg.tar.xz --output neovim.pkg.tar.gz
cd - > /dev/null
