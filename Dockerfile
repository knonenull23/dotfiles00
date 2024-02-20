FROM ubuntu:latest

ARG SKIP_NODEJS
ARG SKIP_NEOVIM

COPY misc/.gitconfig misc/.* /root/

RUN if [ "$SKIP_NODEJS" ]; then exit; fi && \
    echo "Installing NodeJS.." && \
    apt update && \
    apt install -y curl && \
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh -o /tmp/get-nvm.bash; bash /tmp/get-nvm.bash && \
    . /root/.nvm/nvm.sh && nvm install --lts && nvm use --lts 

COPY vim/init.lua /root/.config/nvim/init.lua
RUN if [ "$SKIP_NEOVIM" ]; then exit; fi && \
    echo "Installing Neovim.."  && \
    apt update && \
    apt install -y ripgrep curl git build-essential python3 unzip && \
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage  && \
    chmod u+x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    mv squashfs-root /opt/nvim && \
    ln -s /opt/nvim/AppRun /usr/bin/nvim && \
    if [ "$SKIP_NODEJS" ]; then nvim --headless "+Lazy! sync" +qa; else . /root/.nvm/nvm.sh && nvim +"LspInstall tsserver bashls yamlls pyright lua_ls" +qa; fi