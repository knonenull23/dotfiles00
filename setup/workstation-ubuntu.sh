sudo apt install ripgrep cmake git curl wget clangd python3-pip build-essential freerdp2-dev dnsutils -y
curl -sL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh > /tmp/miniconda.sh; sh /tmp/miniconda.sh

curl -fsSL https://get.docker.com -o /tmp/get-docker.sh; sh /tmp/get-docker.sh
sudo usermod -aG docker $USER

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
./squashfs-root/usr/bin/nvim
sudo cp -r ./squashfs-root/usr/* /usr/local/
rm -r squashfs-root
rm nvim.appimage

curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

# alias run="/usr/share/tomcat9/bin/startup.sh; sleep 3; guacd; vncserver :1"
# alias freerdp="DISPLAY=:1 freerdp-shadow-cli -auth"
