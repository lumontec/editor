#!/bin/bash

nvim_install_path="$HOME/.local"

echo "install vim under $nvim_install_path"
cp -r ./nvim-linux-x86_64/bin/* $nvim_install_path/bin
cp -r ./nvim-linux-x86_64/lib/* $nvim_install_path/lib
cp -r ./nvim-linux-x86_64/share/* $nvim_install_path/share

echo -e "VIM environment variables have been set:\nVIM: $nvim_install_path/bin\nPATH: $nvim_install_path/bin\nVIMRUNTIME: $nvim_install_path/share/vim"

nvim_bin="$nvim_install_path/bin"
nvim_runtime="$nvim_install_path/share/nvim/runtime"

if ! grep -q "export VIM=$nvim_bin" ~/.bashrc; then
    echo "export VIM=$nvim_bin" >> ~/.bashrc
fi
if ! grep -q "export VIMRUNTIME=$nvim_runtime" ~/.bashrc; then
    echo "export VIMRUNTIME=$nvim_runtime" >> ~/.bashrc
fi

if ! grep -q "export PATH=$nvim_bin:\$PATH" ~/.bashrc; then
    echo "export PATH=$nvim_bin:\$PATH" >> ~/.bashrc
fi

source ~/.bashrc
