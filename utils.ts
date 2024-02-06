import 'zx/globals'
import select from '@inquirer/select';

export function termuxRun(): ProcessPromise {
    return $`adb shell "run-as com.termux files/usr/bin/bash -c 'export PATH=/data/data/com.termux/files/usr/bin:$PATH; export LD_PRELOAD=/data/data/com.termux/files/usr/lib/libtermux-exec.so; $COMMAND'"`
}

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
    abstract fileEditingAndManipulation(): Promise<void>
    abstract openSshServer(): Promise<void>
    abstract githubCli(): Promise<void>
    abstract vsCodeEditor(): Promise<void>
    abstract neovim(): Promise<void>
    abstract guacamole(): Promise<void>
    abstract filebrowser(): Promise<void>
    abstract docker(): Promise<void>
    abstract kubernetes(): Promise<void>
    abstract termux(): Promise<void>
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
        const extensions = fs.readJsonSync('conf/vscode/extensions.json')
        for (const extension of extensions['extensions']) {
            await $`code --install-extension ${extension}`
        }
    }

    async neovim(): Promise<void> {
        log_info("Installing Neovim on Ubuntu")
        await $`mkdir -p ${os.homedir()}/.nvim; mkdir -p ${os.homedir()}/.config; mkdir -p ${os.homedir()}/.local/share`
        await $`mkdir -p ${os.homedir()}/.nvim/config/nvim; ln -sf ${os.homedir()}/.nvim/config/nvim ${os.homedir()}/.config`
        await $`mkdir -p ${os.homedir()}/.nvim/share/nvim; ln -sf ${os.homedir()}/.nvim/share/nvim ${os.homedir()}/.local/share`
        await $`cp conf/vim/init.lua ${os.homedir()}/.nvim/config/nvim/init.lua`
        await $`mkdir -p /tmp/neovim-install`
        cd("/tmp/neovim-install")
        await $`curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage`
        await $`chmod u+x nvim.appimage`
        await $`./nvim.appimage --appimage-extract`
        await $`cp -r squashfs-root ${os.homedir()}/.nvim`
        await $`sudo ln -sf ${os.homedir()}/.nvim/squashfs-root/AppRun /usr/local/bin/nvim`

        await $`curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh -o /tmp/get-nvm.bash; bash /tmp/get-nvm.bash`
        log_warn("Run the following command before running nvim to install all the plugins")
        log_warn("source ~/.bashrc; nvm install --lts; nvim use --lts")
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

    async filebrowser(): Promise<void> {
        await $`curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash`
    }

    async docker(): Promise<void> {
        await $`curl -fsSL https://get.docker.com -o /tmp/get-docker.sh; sh /tmp/get-docker.sh`
        await $`sudo usermod -aG docker ${os.userInfo().username}`
    }

    async kubernetes(): Promise<void> {
        await $`curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64`
        await $`sudo mv minikube-linux-amd64 /usr/local/bin/minikube`
        await $`chmod +x /usr/local/bin/minikube`

        await $`curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"`
        await $`sudo mv kubectl /usr/local/bin/kubectl`
        await $`chmod +x /usr/local/bin/kubectl`

        await $`curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash`
        await $`sudo mv kustomize /usr/local/bin/kustomize`
        await $`chmod +x /usr/local/bin/kustomize`

        await $`sudo sysctl fs.inotify.max_user_instances=1280`
        await $`sudo sysctl fs.inotify.max_user_watches=655360`
    }

    async termux(): Promise<void> {
        await $`sudo apt update`
        await $`sudo apt install -y android-sdk-platform-tools`
        await $`adb start-server`
        log_warn("Ensure Termux is installed and uses a debug build: https://github.com/termux/termux-app/releases")
        await question("Connnect your device to the computer, and activate USB debugging. Ensure that the device is authorized.")

        // Select Device to Bootstrap
        const devices = await $`adb devices`.pipe($`cat`).pipe($`tail -n +2`).pipe($`grep -P 'device'`)
        let choices: { name: string; value: string }[] = [] // Define the type of choices array
        for (let device of devices.stdout.split("\n")) {
            choices.push({ name: device, value: device.split(/\s+/)[0] })
        }
        const selectedDevice = await select({
            message: 'Select the device to bootstrap.',
            choices: choices
        })
        log_info(`Selected device: ${selectedDevice}`)

        // Prefer OOM Killer from terminating Termux
        log_info("Fix Process OOM Killer..")
        await $`adb shell "/system/bin/device_config set_sync_disabled_for_tests persistent"`
        await $`adb shell "/system/bin/device_config put activity_manager max_phantom_processes 2147483647"`
        await $`adb shell settings put global settings_enable_monitor_phantom_procs false`

        log_info("Updating Termux..")
        await question("Press Enter to Continue..")
        process.env.COMMAND = "pkg update -y"; await termuxRun()
        process.env.COMMAND = "pkg install openssh proot proot-distro -y"; await termuxRun()
        process.env.COMMAND = "proot-distro install archlinux || true"; await termuxRun()
        process.env.COMMAND = "proot-distro login archlinux -- pacman -Syu --noconfirm"; await termuxRun()
        process.env.COMMAND = "proot-distro login archlinux -- pacman -Sy --noconfirm unzip base-devel git github-cli neovim nss libxss tmux neovim lsof nodejs npm ripgrep python dnsutils xfce4 xdg-utils"; await termuxRun()
        process.env.COMMAND = "proot-distro login archlinux -- useradd -m arch || true"; await termuxRun()
        log_warn("Run the following command to enable sudo for the arch user")
        log_warn("proot-distro login archlinux; echo 'arch ALL=(ALL) ALL' >> /etc/sudoers")
        // process.env.COMMAND = "proot-distro login archlinux -- git clone https://aur.archlinux.org/visual-studio-code-bin.git; cd visual-studio-code-bin; makepkg -si"; await termuxRun()
        // rm -r /home/arch/.config/Code/Cache /home/arch/.config/Code/CachedData/
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
