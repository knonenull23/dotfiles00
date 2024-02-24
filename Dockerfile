FROM ubuntu:latest

ARG SKIP_NODEJS
ARG SKIP_NEOVIM
ARG SKIP_OPENSSH

RUN apt update && \
    apt install -y tmux curl git iputils-ping dnsutils openssl nmap xclip sudo bash-completion gh && \
    echo ". /etc/bash_completion" >> $HOME/.bashrc && \
    echo "alias tmux='tmux -2'" >> $HOME/.bashrc

RUN if [ "$SKIP_OPENSSH" ]; then exit; fi && \
    apt install -y openssh-server && \
    ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N "" && \
    mkdir /run/sshd && \
    cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

RUN if [ "$SKIP_NODEJS" ]; then exit; fi && \
    echo "Installing NodeJS.." && \
    apt update && \
    apt install -y curl && \
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh -o /tmp/get-nvm.bash; bash /tmp/get-nvm.bash && \
    /bin/bash -c ". /root/.nvm/nvm.sh && nvm install --lts && nvm use --lts"

COPY vim/init.lua /root/.config/nvim/init.lua
RUN if [ "$SKIP_NEOVIM" ]; then exit; fi && \
    echo "Installing Neovim.."  && \
    apt update && \
    apt install -y ripgrep curl git build-essential python3 python3-pip unzip && \
    python3 -m pip install --user python-dotenv requests pynvim==0.5.0 prompt-toolkit pysocks && \
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage  && \
    chmod u+x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    rm nvim.appimage && \
    mv squashfs-root /opt/nvim && \
    ln -s /opt/nvim/AppRun /usr/bin/nvim && \
    if [ "$SKIP_NODEJS" ]; then nvim --headless "+Lazy! sync" +qa; else /bin/bash -c ". /root/.nvm/nvm.sh && nvim +'LspInstall tsserver bashls yamlls pyright lua_ls jsonls' +qa && nvim --headless +UpdateRemotePlugins +qa"; fi

CMD ["/usr/sbin/sshd" ,"-D", "-o", "ListenAddress=0.0.0.0", "-o", "PermitRootLogin=yes", "-p", "2222"]
