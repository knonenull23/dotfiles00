#! /usr/bin/env -S bun run

/*
Pre-requisites
curl -fsSL https://bun.sh/install | bash
*/


import 'zx/globals'
import { log_info, log_warn, log_error } from './utils'
import checkbox, { Separator } from '@inquirer/checkbox';
import { getInstaller } from './utils'


const choices = await checkbox({
    message: 'Select capabilities to install.',
    choices: [
        { name: 'File Editing and Manipulation', value: 'fileEditingAndManipulation' },
        { name: 'OpenSSH Server', value: 'openSshServer' },
        { name: 'Github CLI', value: 'githubCli' },
        { name: 'VS Code Editor', value: 'vsCodeEditor' },
    ],
});

log_info(`Selected capabilities: ${choices}`)
const install = getInstaller()

for (const choice of choices) {
    switch (choice) {
        case 'fileEditingAndManipulation':
            install.fileEditingAndManipulation()
            break;
        case 'openSshServer':
            install.openSshServer()
            break;
        case 'githubCli':
            install.githubCli()
            break;
        case 'vsCodeEditor':
            break;
        default:
            log_error(`Unknown capability: ${choice}`);
            break;
    }
}