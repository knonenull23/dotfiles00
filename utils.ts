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
    abstract guacamole(): void
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

    async vsCodeEditor(): Promise<void> {
        log_info("Installing VS Code Editor on Ubuntu")
        await $`sudo apt -y install wget gpg`
        await $`wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg`
        await $`sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg`
        await $`sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'`
        await $`rm -f packages.microsoft.gpg`
        await $`sudo apt install apt-transport-https`
        await $`sudo apt update`
        await $`sudo apt -y install code`
    }

    async guacamole(): Promise<void> {
        log_info("Installing Guacamole on Ubuntu")
        await $`sudo apt update`
        await $`sudo apt install -y git make libcairo2-dev libjpeg-turbo8-dev libpng-dev libtool-bin uuid-dev libossp-uuid-dev libvncserver-dev autotools-dev libssh2-1-dev openssh-server`
        await $`sudo apt install -y default-jdk tomcat9 tomcat9-admin tomcat9-common tomcat9-user`
        await $`sudo apt install -y x11vnc tigervnc-standalone-server`
        await $`sudo apt -y autoremove`

        await $`mkdir -p /tmp/guacamole-install`
        await $`sudo mkdir -p /etc/guacamole`
        await $`sudo cp conf/guacamole/guacamole.properties /etc/guacamole/guacamole.properties`
        await $`sudo cp conf/guacamole/user-mapping.xml /etc/guacamole/user-mapping.xml`

        cd('/tmp/guacamole-install')
        await $`if cd guacamole-server; then git pull; else git clone https://www.github.com/apache/guacamole-server.git; fi`
        cd('/tmp/guacamole-install/guacamole-server')
        await $`autoreconf -fi`
        await $`./configure --with-init-dir=/etc/init.d`
        await $`make`
        await $`sudo make install`
        await $`sudo ldconfig`
        await $`sudo systemctl enable tomcat9`
        await $`sudo systemctl enable guacd`

        await $`wget https://archive.apache.org/dist/guacamole/1.5.3/binary/guacamole-1.5.3.war`
        await $`sudo mv guacamole-1.5.3.war /var/lib/tomcat9/webapps/guacamole.war`

        const successTomcat = await $`systemctl is-active tomcat9`
        if (successTomcat.stdout.match('inactive')) {
            log_error("Tomcat Server is not active.")
        }

        const successGuacd = await $`systemctl is-active tomcat9`
        if (successGuacd.stdout.match('inactive')) {
            log_error("Guacd Server is not active.")
        }

        await $`vncpasswd`
        await $`Run the following command to start a VNC on :0`
        await $`x11vnc -bg -reopen -forever -display :0`
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