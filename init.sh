#!/usr/bin/env bash

# Configuration initialization script for dotfiles
# Repository: https://github.com/tintty1/config.git

set -e

echo "Initializing configuration setup..."
echo "Repository: https://github.com/tintty1/config.git"
echo ""

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to run initialization scripts
run_init_script() {
    local component="$1"
    local script_path="$SCRIPT_DIR/$component/init.sh"

    if [[ -f "$script_path" ]]; then
        echo "Initializing $component..."
        chmod +x "$script_path"
        if "$script_path"; then
            echo "$component initialized successfully"
        else
            echo "Failed to initialize $component"
            return 1
        fi
    else
        echo "No init script found for $component at $script_path"
    fi
    echo ""
}

# Initialize Zsh configuration
echo "=== ZSH CONFIGURATION ==="
run_init_script "zsh"

# Initialize Tmux configuration
echo "=== TMUX CONFIGURATION ==="
run_init_script "tmux"

# Initialize Neovim configuration
echo "=== NEOVIM CONFIGURATION ==="
echo "Initializing neovim..."

# Check if nvim is installed
if ! command_exists nvim; then
    echo "Neovim is not installed. Please install it first:"
    echo "   Ubuntu/Debian: sudo apt install neovim"
    echo "   Arch Linux: sudo pacman -S neovim"
    echo "   macOS: brew install neovim"
    echo ""
else
    echo "Neovim is installed"

    # Create ~/.config directory if it doesn't exist
    mkdir -p "$HOME/.config"

    # Backup existing neovim config if it exists and is not a symlink
    if [[ -d "$HOME/.config/nvim" && ! -L "$HOME/.config/nvim" ]]; then
        echo "Backing up existing nvim config to nvim.backup"
        mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup"
    fi

    # Create symlink for nvim configuration
    if [[ ! -L "$HOME/.config/nvim" || "$(readlink "$HOME/.config/nvim")" != "$SCRIPT_DIR/nvim" ]]; then
        ln -sf "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"
        echo "Created symlink for neovim configuration"
    else
        echo "Neovim symlink already exists"
    fi

    echo "Neovim initialized successfully"
fi
echo ""

echo "Configuration setup completed!"
echo ""
echo "Next steps:"
echo "   • Restart your shell or run 'source ~/.zshrc'"
echo "   • Open tmux and install plugins with prefix + I"
echo "   • Open neovim to automatically install plugins"
echo ""
echo "For more information, check the README files in each component directory."