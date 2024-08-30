#!/bin/bash

vim_install_path="$HOME/.local"
nvm_version="v0.40.1"
node_version="v18.20.4"

echo "install nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$nvm_version/install.sh | bash

echo "download and use node $node_version"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install $node_version 
nvm alias default $node_version

echo "install vim under $vim_install_path"
cp -r ./vim/bin/* $vim_install_path/bin
cp -r ./vim/share/applications* $vim_install_path/share/applications
cp -r ./vim/share/icons* $vim_install_path/share/icons
cp -r ./vim/share/man* $vim_install_path/share/man
cp -r ./vim/share/vim* $vim_install_path/share/vim

echo -e "VIM environment variables have been set:\nVIM: $vim_install_path/bin\nPATH: $vim_install_path/bin\nVIMRUNTIME: $vim_install_path/share/vim"

vim_bin="$vim_install_path/bin"
vim_runtime="$vim_install_path/share/vim/vim91"

if ! grep -q "export VIM=$vim_bin" ~/.bashrc; then
    echo "export VIM=$vim_bin" >> ~/.bashrc
fi
if ! grep -q "export VIMRUNTIME=$vim_runtime" ~/.bashrc; then
    echo "export VIMRUNTIME=$vim_runtime" >> ~/.bashrc
fi

if ! grep -q "export PATH=$vim_bin:\$PATH" ~/.bashrc; then
    echo "export PATH=$vim_bin:\$PATH" >> ~/.bashrc
fi

source ~/.bashrc

echo "install vim plugged"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "copy .vimrc"
cp ./dotvim/.vimrc $HOME/.vimrc

echo "install plugins"
vim +PlugInstall +qall

echo "copy coc-config"
cp ./dotvim/coc-settings.json ~/.vim/coc-settings.json

