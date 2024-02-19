FROM ubuntu:latest

ARG INSTALL_NEOVIM

COPY vim/init.lua /root/.config/nvim/init.lua
RUN /bin/bash <<EOF
if [ "$INSTALL_NEOVIM" ]; then
    echo "Installing Neovim" 
    apt update
    apt install -y ripgrep curl git
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage 
    chmod u+x nvim.appimage
    ./nvim.appimage --appimage-extract
    mv squashfs-root /opt/nvim
    ln -s /opt/nvim/AppRun /usr/bin/nvim
fi
EOF