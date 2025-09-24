#!/usr/bin/env bash

echo "Initializing Tmux configuration..."

# Check if tmux is installed
if ! command -v tmux &> /dev/null; then
    echo "Tmux is not installed. Please install tmux first:"
    echo "   Ubuntu/Debian: sudo apt install tmux"
    echo "   Arch Linux: sudo pacman -S tmux"
    echo "   macOS: brew install tmux"
    exit 1
fi

echo "Tmux is installed"

# Install TPM (Tmux Plugin Manager)
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    echo "Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

    if [[ $? -ne 0 ]]; then
        echo "Failed to install TPM"
        exit 1
    fi
    echo "TPM installed successfully"
else
    echo "TPM already installed"
fi

# Get the directory - use argument if provided, otherwise use script location
if [[ -n "$1" ]]; then
    SCRIPT_DIR="$1"
else
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
fi

# Create symbolic link for tmux configuration
echo "Creating symbolic link for tmux configuration..."

# Backup existing .tmux.conf if it exists and is not a symlink
if [[ -f "$HOME/.tmux.conf" && ! -L "$HOME/.tmux.conf" ]]; then
    echo "Backing up existing .tmux.conf to .tmux.conf.backup"
    mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.backup"
fi

# Create symlink for .tmux.conf
if [[ ! -L "$HOME/.tmux.conf" || "$(readlink "$HOME/.tmux.conf")" != "$SCRIPT_DIR/.tmux.conf" ]]; then
    ln -sf "$SCRIPT_DIR/.tmux.conf" "$HOME/.tmux.conf"
    echo "Created symlink for .tmux.conf"
else
    echo ".tmux.conf symlink already exists"
fi

echo "Tmux configuration initialized successfully!"
echo "To install plugins:"
echo "   1. Start tmux: tmux"
echo "   2. Press prefix + I (capital i) to install plugins"
echo "   3. Press prefix + U to update plugins"
echo ""
echo "Key bindings:"
echo "   • h/j/k/l - Navigate panes (vi-style)"
echo "   • F12 - Toggle nested session mode"
echo "   • prefix + \\ - Easy motion (after plugin installation)"