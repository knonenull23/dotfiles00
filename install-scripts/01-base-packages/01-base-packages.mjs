#!/usr/bin/env zx

await $`apt update`
await $`apt install git curl wget -y`
console.log(chalk.green("Done."))
