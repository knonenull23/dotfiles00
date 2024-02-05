import 'zx/globals'

export function log_info(message: string): void {
    console.log(Date().toString() + " " + chalk.green(message))
}

export function log_warn(message: string): void {
    console.log(Date().toString() + " " + chalk.yellow(message))
}

export function log_error(message: string): void {
    console.log(Date().toString() + " " + chalk.red(message))
}

enum OperatingSystem {
    Linux_Ubuntu,
    Linux_Arch

}

enum CpuArchitecture {
    x86_64,
    arm64
}

abstract class Installer {
    abstract fileEditingAndManipulation(): void
    abstract openSshServer(): void
    abstract githubCli(): void
    abstract vsCodeEditor(): void
}

class x64UbuntuInstaller extends Installer {
    async fileEditingAndManipulation(): Promise<void> {
        log_info("Installing file editing and manipulation capabilities on Ubuntu")
        await $`sudo apt update`
        await $`sudo apt install -y vim wget curl git zip unzip dnsutils lsof`
        await $`sudo apt -y autoremove`
    }

    async openSshServer(): Promise<void> {
        await $`sudo apt update`
        await $`sudo apt install -y openssh-server`
        await $`ssh-keygen`
        await $`sudo apt -y autoremove`
        const success = await $`systemctl is-active ssh`
        if (success.stdout.match('inactive')) {
            log_error("OpenSSH Server is not active.")
        }
    }

    async githubCli(): Promise<void> {
        log_info("Installing Github CLI on Ubuntu")
        await $`type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)`
        await $`curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg`
        await $`sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg`
        await $`echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null`
        await $`sudo apt update`
        await $`sudo apt install gh -y`
        await $`gh auth login`
    }

    vsCodeEditor(): void {
        log_info("Installing VS Code Editor on Ubuntu")
    }
}

export function getOperatingSystem(): OperatingSystem {
    const osRelease = fs.readFileSync('/etc/os-release', 'utf8')
    if (osRelease.includes("Ubuntu")) {
        log_info(`Operating system: Ubuntu`)
        return OperatingSystem.Linux_Ubuntu;
    }

    throw new Error("Unsupported operating system")
}

export function getCpuArchitecture(): CpuArchitecture {
    const cpuInfo = os.arch();
    if (cpuInfo.includes("x64")) {
        log_info(`Operating system: x86_64`)
        return CpuArchitecture.x86_64
    }

    throw new Error("Unsupported CPU architecture")
}

export function getInstaller(): Installer {
    const _os = getOperatingSystem()
    const _arch = getCpuArchitecture()
    if (_arch === CpuArchitecture.x86_64 && _os === OperatingSystem.Linux_Ubuntu) {
        return new x64UbuntuInstaller()
    }

    throw new Error("Installer not implemented.")
}