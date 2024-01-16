cd /tmp
git clone https://aur.archlinux.org/visual-studio-code-bin.git
cd visual-studio-code-bin

makepkg -si

# Run this if vscode hangs on startup
# rm -r /home/arch/.config/Code/Cache /home/arch/.config/Code/CachedData/

