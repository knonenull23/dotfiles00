#!/usr/bin/env zx

const homeDir = os.homedir()
const installFolder = `${homeDir}/.local/share/nvim`

await $`git clone https://github.com/golang/vscode-go ${installFolder}/vscode-go`.nothrow()
await $`cd ${installFolder}/vscode-go && npm install && npm run compile`

