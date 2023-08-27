#!/usr/bin/env zx

// await $`sudo apt update`
// await $`sudo apt install ripgrep neovim -y`

const homeDir = os.homedir()
await $`mkdir -p ${homeDir}/.config/nvim`

console.log(chalk.blue(`Symlink ${__dirname}/init.vim to ${homeDir}/.config/nvim/init.vim`))
const ok = await question(`Ok? (y/n [n]) `)

if (ok.toLowerCase().startsWith("y")) {
    await $`ln -s  ${__dirname}/init.vim ${homeDir}/.config/nvim/init.vim`
}

