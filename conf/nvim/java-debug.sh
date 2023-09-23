#!/bin/sh
set -e

mkdir -p $HOME/.local/share/nvim
cd $HOME/.local/share/nvim
git clone https://github.com/microsoft/java-debug.git java-debug && cd java-debug && ./mvnw clean install
git clone https://github.com/microsoft/vscode-java-test.git vscode-java-test && cd vscode-java-test && npm install && npm run build-plugin
