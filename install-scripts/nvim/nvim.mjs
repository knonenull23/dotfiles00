#!/usr/bin/env zx

await $`sudo pacman -Syu neovim ripgrep cmake`
await $`python3 -m pip install debugpy --break-system-packages`

const homeDir = os.homedir()
await $`mkdir -p ${homeDir}/.config/nvim`

console.log(chalk.blue(`Symlink ${__dirname}/lua and ${__dirname}/init.lua to ${homeDir}/.config/nvim`))
const ok = await question(`Ok? (y/n [n]) `)

if (ok.toLowerCase().startsWith("y")) {
    await $`ln -s  ${__dirname}/lua ${homeDir}/.config/nvim/`
    await $`ln -s  ${__dirname}/init.lua ${homeDir}/.config/nvim/`
}
