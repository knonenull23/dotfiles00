pacman -Syu
pacman -Sy base-devel git github-cli tmux neovim nss lsof nodejs npm ripgrep python
useradd -m arch
echo "arch ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
