# sudo pacman -Syu
# sudo pacman -S base-devel git tmux neovim xfce4 github-cli zip ripgrep dnsutils python python-pip

mkdir $HOME/.virtualenvs
cd $HOME/.virtualenvs
python -m venv debugpy
debugpy/bin/python -m pip install debugpy
