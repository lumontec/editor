#!/bin/bash

# Detect system architecture
arch=$(uname -m)
case "$arch" in
    x86_64)
        nvim_dir="nvim-linux-x86_64"
        ;;
    aarch64)
        nvim_dir="nvim-linux-arm64"
        ;;
    *)
        echo "Unsupported architecture: $arch"
        exit 1
        ;;
esac

echo "Detected architecture: $arch"
echo "Installing Neovim from $nvim_dir"

nvim_install_path="$HOME/.local"

echo "Installing Neovim under $nvim_install_path"
mkdir -p "$nvim_install_path/bin" "$nvim_install_path/lib" "$nvim_install_path/share"

cp -r "./$nvim_dir/bin/"* "$nvim_install_path/bin"
cp -r "./$nvim_dir/lib/"* "$nvim_install_path/lib"
cp -r "./$nvim_dir/share/"* "$nvim_install_path/share"

nvim_bin="$nvim_install_path/bin"
nvim_runtime="$nvim_install_path/share/nvim/runtime"

# Add alias to .bashrc if not already present
if ! grep -q "alias nvim='VIMRUNTIME=$nvim_runtime nvim'" ~/.bashrc; then
    echo "alias nvim='VIMRUNTIME=$nvim_runtime nvim'" >> ~/.bashrc
fi

# Add Neovim binary path to .bashrc if not already present
if ! grep -q "export PATH=$nvim_bin:\$PATH" ~/.bashrc; then
    echo "export PATH=$nvim_bin:\$PATH" >> ~/.bashrc
fi

echo "Copying over initialization files"
rm -rf "$HOME/.config/nvim"
cp -rf ./kickstart.nvim "$HOME/.config/nvim"

echo "Neovim installation complete. Please restart your shell or run 'source ~/.bashrc' to apply changes."

