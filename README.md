# dotfiles

Various configuration and setup files.

### Pre-Requisites

```
# Basics
sudo apt install git curl chromium-browser -y
sudo snap install chromium

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
# Build all
docker build --progress plain -t dev .

# Skip certain modules
docker build --build-arg SKIP_NEOVIM=y --progress plain -t dev .
```
