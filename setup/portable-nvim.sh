# unzip nvim.zip into /opt/nvim
# unzip node into /opt/node
# Save in .bashrc:
# export PATH=$PATH:/opt/node/bin
# alias nvim="/opt/nvim/squashfs-root/AppRun"

ln -s /opt/nvim/config/nvim/ $HOME/.config/
ln -s /opt/nvim/share/nvim/ $HOME/.local/share/

# fix symlinks
rm $HOME/.local/share/nvim/mason/bin/*
ln -s $HOME/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript-language-server/lib/cli.mjs $HOME/.local/share/nvim/mason/bin/typescript-language-server
ln -s $HOME/.local/share/nvim/mason/packages/pyright/node_modules/pyright/langserver.index.js $HOME/.local/share/nvim/mason/bin/pyright-langserver
ln -s $HOME/.local/share/nvim/mason/packages/pyright/node_modules/pyright/index.js $HOME/.local/share/nvim/mason/bin/pyright
ln -s $HOME/.local/share/nvim/mason/packages/bash-language-server/node_modules/bash-language-server/out/cli.js $HOME/.local/share/nvim/mason/bin/bash-language-server
ln -s $HOME/.local/share/nvim/mason/packages/lua-language-server/lua-language-server $HOME/.local/share/nvim/mason/bin/lua-language-server
ln -s $HOME/.local/share/nvim/mason/packages/yaml-language-server/node_modules/yaml-language-server/bin/yaml-language-server $HOME/.local/share/nvim/mason/bin/yaml-language-server
