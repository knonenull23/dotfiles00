#!/usr/bin/env zx

await $`apt update`
await $`apt install ripgrep neovim -y`

const homeDir = os.homedir()

console.log(chalk.blue(`Copying init.vim to ${homeDir}/.config/nvim/init.vim`))

if (fs.exists(`${homeDir}/.config/nvim/init.vim`)) {
  const overwrite = await question(
    `Do you want to overwrite? (y/n [n]) `
  )
  if (overwrite.toLowerCase().startsWith("y")) {
    await $`cp init.vim ${homeDir}/.config/nvim/init.vim`
  } else {
    console.log(chalk.blue(`Not overwriting.`))
  }
} else {
  await $`cp init.vim ${homeDir}/.config/nvim/init.vim`
}
