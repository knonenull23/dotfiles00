#!/usr/bin/env zx

const homeDir = os.homedir()
const installFolder = `${homeDir}/.local/share/nvim`

await $`git clone https://github.com/microsoft/java-debug.git ${installFolder}/java-debug`.nothrow()
await $`cd ${installFolder}/java-debug && ./mvnw clean install`

await $`git clone https://github.com/microsoft/vscode-java-test.git ${installFolder}/vscode-java-test`.nothrow()
await $`cd ${installFolder}/vscode-java-test && npm install && npm run build-plugin`
