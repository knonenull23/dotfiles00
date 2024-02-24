# dotfiles

Various configuration and setup files.

### Pre-Requisites

```
# Basics
sudo apt install git curl chromium-browser -y

# Docker
curl -fsSL https://get.docker.com | bash -
sudo usermod -aG docker $USER

# Github CLI
sudo apt install gh -y
gh auth login
cp misc/gitconfig $HOME/.gitconfig

# VSCode
curl -L -o /tmp/code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" && sudo dpkg -i code.deb
cp vscode/keybindings.json $HOME/.config/Code/User/keybindings.json
cp vscode/settings.json $HOME/.config/Code/User/settings.json
cat vscode/extensions | xargs -I{} code --install-extension {}
```

### Set up Development Containers

```
# Create hidden versions of config files in .misc [optional]

# Build all
docker build --progress plain -t dev .

# Skip certain modules
docker build --network=host --build-arg SKIP_NEOVIM=y --progress plain -t dev .

# Run
## With sshd 
docker run --name dev -d --network=host --restart=always -v workspaces:/root/workspaces dev
ssh-keygen -b 2048 -t rsa 
docker cp ~/.ssh/id_rsa.pub dev:/root/.ssh/authorized_keys
docker exec -it --user root dev chown -R root:root /root/.ssh/authorized_keys
ssh -p 2222 root@127.0.0.1

## Without sshd
docker run --name dev -it -d --network=host --restart=always -v workspaces:/root/workspaces dev bash
```
