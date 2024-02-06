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
        { name: 'Neovim', value: 'neovim' },
        { name: 'Guacamole', value: 'guacamole' },
        { name: 'FileBrowser', value: 'filebrowser' },
        { name: 'Docker', value: 'docker' },
        { name: 'Kubernetes', value: 'kubernetes' },
    ],
});

log_info(`Selected capabilities: ${choices}`)
const install = getInstaller()

for (const choice of choices) {
    switch (choice) {
        case 'fileEditingAndManipulation':
            await install.fileEditingAndManipulation()
            break;
        case 'openSshServer':
            await install.openSshServer()
            break;
        case 'githubCli':
            await install.githubCli()
            break;
        case 'vsCodeEditor':
            await install.vsCodeEditor()
            break;
        case 'neovim':
            await install.neovim()
            break;
        case 'guacamole':
            await install.guacamole()
            break;
        case 'filebrowser':
            await install.filebrowser()
            break;
        case 'docker':
            await install.docker()
            break;
        case 'kubernetes':
            await install.kubernetes()
            break;
        default:
            log_error(`Unknown capability: ${choice}`);
            break;
    }
}