#!/usr/bin/env zx

await $`npm install -g @waylaidwanderer/chatgpt-api`

const homeDir = os.homedir()
console.log(chalk.blue(`Copy ${__dirname}/settings.json to ${homeDir}/settings.js`))
const ok = await question(`Ok? (y/n [n]) `)

if (ok.toLowerCase().startsWith("y")) {
    await $`cp  ${__dirname}/settings.js ${homeDir}/settings.js`
}
