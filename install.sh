#!/bin/bash

DOTFILES_DIR="$HOME/.dotfiles"
CONFIG_DIR="$HOME/.config"

echo "Setting up dotfiles..."

# Ensure the .dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Error: $DOTFILES_DIR not found. Please clone your dotfiles repository first."
    exit 1
fi

# Create symlinks for dotfiles
ln -sf "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/vimrc" "$HOME/.vimrc"
ln -sf "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"

# Ensure config directories exist
mkdir -p "$CONFIG_DIR/alacritty"
mkdir -p "$CONFIG_DIR/nvim"

# Create symlinks for config files
ln -sf "$DOTFILES_DIR/alacritty.toml" "$CONFIG_DIR/alacritty/alacritty.toml"
ln -sf "$DOTFILES_DIR/init.vim" "$CONFIG_DIR/nvim/init.vim"

echo "Dotfiles setup complete."
