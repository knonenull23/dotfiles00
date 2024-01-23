pacman -Syu
pacman -Sy base-devel git github-cli tmux neovim xfce4 nss libxss lsof xdg-utils nodejs npm ripgrep python dnsutils
useradd -m arch
echo "arch ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
