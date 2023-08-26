#!/usr/bin/env zx

await $`sudo apt update`
await $`sudo apt install git curl wget -y`
console.log(chalk.green("Done."))
