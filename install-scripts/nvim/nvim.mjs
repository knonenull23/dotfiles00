#!/usr/bin/env zx

await $`curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage`
await $`chmod u+x nvim.appimage`
await $`sudo mv nvim.appimage /usr/bin/nvim`

const homeDir = os.homedir()
await $`mkdir -p ${homeDir}/.config/nvim`

console.log(chalk.blue(`Symlink ${__dirname}/init.vim to ${homeDir}/.config/nvim/init.vim`))
const ok = await question(`Ok? (y/n [n]) `)

if (ok.toLowerCase().startsWith("y")) {
    await $`ln -s  ${__dirname}/init.vim ${homeDir}/.config/nvim/init.vim`
}

