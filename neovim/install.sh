#!/bin/bash

nvim_install_path="$HOME/.local"

echo "install vim under $nvim_install_path"
cp -r ./nvim-linux-x86_64/bin/* $nvim_install_path/bin
cp -r ./nvim-linux-x86_64/lib/* $nvim_install_path/lib
cp -r ./nvim-linux-x86_64/share/* $nvim_install_path/share


nvim_bin="$nvim_install_path/bin"
nvim_runtime="$nvim_install_path/share/nvim/runtime"

if ! grep -q "alias nvim='VIMRUNTIME=$nvim_runtime nvim'" ~/.bashrc; then
    echo "alias nvim='VIMRUNTIME=$nvim_runtime nvim'" >> ~/.bashrc
fi

if ! grep -q "export PATH=$nvim_bin:\$PATH" ~/.bashrc; then
    echo "export PATH=$nvim_bin:\$PATH" >> ~/.bashrc
fi

echo "copying over initialization files"
cp -rf ./kickstart.nvim $HOME/.config/nvim

source ~/.bashrc
