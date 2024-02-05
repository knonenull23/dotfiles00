#!/usr/bin/env zx

/* Pre-requisites
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install --lts && nvm use --lts
npm install -g zx
npm install
*/

import { select } from '@inquirer/prompts';
import { exit } from 'process';
import "zx/globals"
import os from 'os';

async function getOperatingSystem() {
    const data = await fs.readFile('/etc/os-release', 'utf8');

    if (data.includes("Ubuntu")) {
        console.log("Detected OS: ubuntu");
        return "ubuntu";
    } else if (data.includes("Arch")) {
        console.log("Detected OS: arch");
        return "arch";
    } else {
        console.error("Unsupported Operating System");
        process.exit(1);
    }
}

async function getCpuArchitecture() {
    const validArch = ['arm64', 'x64'];
    const detectedArch = os.arch();
    if (validArch.includes(detectedArch)) {
        console.log(`Detected Architecture: ${detectedArch}`);
        return detectedArch;
    } else {
        console.error("Unsupported CPU Architecture");
        exit(1);
    }
}

class Installer {
    installBasePackages() {
        console.log.info("Installing base packages..")
    }
}
class X64UbuntuInstaller extends Installer {
    async installBasePackages() {
        await $`sudo apt update`;
        await $`sudo apt install -y git curl vim neovim unzip`;
    }
}

class ArmArchInstaller extends Installer {
    async installBasePackages() {
        throw new Error("Not implemented yet")
    }
}

function getInstaller(os, arch) {
    if (os === "ubuntu" && arch === "x64") {
        return new X64UbuntuInstaller();
    } else if (os === "arch" && arch === "arm64") {
        return new ArmArchInstaller();
    } else {
        throw new Error("Unsupported Operating System or CPU Architecture");

    }

}

const _os = await getOperatingSystem()
const _arch = await getCpuArchitecture()
const _installer = getInstaller(_os, _arch)

// Get action to take
const action = await select({
    message: 'What do you want to do?',
    choices: [
        {
            name: 'Install Base Packages',
            value: 'baseInstall',
            description: 'Install basic packages for file editing and manipulation.',
        },
    ],
});

switch (action) {
    case "baseInstall":
        await _installer.installBasePackages()
        break;
    default:
        console.error("Invalid action")
        process.exit(1)
}