#!/bin/sh

version=$(curl -s 'https://api.github.com/repos/nvm-sh/nvm/tags' | jq -r '.[0].name')

curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$version/install.sh" | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && nvm install --lts
