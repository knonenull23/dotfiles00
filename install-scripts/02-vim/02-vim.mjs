#!/usr/bin/env zx

await $`sudo apt update`
await $`sudo apt install ripgrep neovim -y`

const homeDir = os.homedir()
await $`mkdir -p ${homeDir}/.config/nvim`

console.log(chalk.blue(`Copying init.vim to ${homeDir}/.config/nvim/init.vim`))
const overwrite = await question(`Do you want to overwrite? (y/n [n]) `)

if (overwrite.toLowerCase().startsWith("y")) {
  await $`cp init.vim ${homeDir}/.config/nvim/init.vim`
} else {
  console.log(chalk.blue(`Not overwriting.`))
}
