#!/usr/bin/env zx

await $`apt update`
await $`apt install git ripgrep neovim -y`
console.log(chalk.green("Done."))
