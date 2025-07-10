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

nvim_install_path="$HOME/.local-$arch"

echo "Installing Neovim under $nvim_install_path"
mkdir -p "$nvim_install_path/bin" "$nvim_install_path/lib" "$nvim_install_path/share"

cp -r "./$nvim_dir/bin/"* "$nvim_install_path/bin"
cp -r "./$nvim_dir/lib/"* "$nvim_install_path/lib"
cp -r "./$nvim_dir/share/"* "$nvim_install_path/share"

nvim_bin="$nvim_install_path/bin"
nvim_runtime="$nvim_install_path/share/nvim/runtime"

if ! grep -q "^nvim()" ~/.bashrc; then
    cat << 'EOF' >> ~/.bashrc

# Neovim function with architecture-specific paths
nvim() {
    XDG_DATA_HOME=/home/lmontech/.local-$(uname -m)/share \
    XDG_STATE_HOME=/home/lmontech/.local-$(uname -m)/state \
    VIMRUNTIME=/home/lmontech/.local-$(uname -m)/share/nvim/runtime \
    /home/lmontech/.local-$(uname -m)/bin/nvim "$@"
}
EOF
fi

echo "Copying over initialization files"
rm -rf "$HOME/.config/nvim"
cp -rf ./kickstart.nvim "$HOME/.config/nvim"

echo "Neovim installation complete. Please restart your shell or run 'source ~/.bashrc' to apply changes."

### info for clangd install on arm ###
# It will likely not work with mason !!, use this hack instead
# sudo apt install clangd-16
# ln -s /usr/bin/clangd-16 ~/.local/share/nvim/mason/bin/clangd
# mkdir ~/.local/share/nvim/mason/packages/clangd# 
#
