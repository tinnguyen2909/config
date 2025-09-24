#!/usr/bin/env zsh

echo "Initializing Zsh configuration..."

# Check if Oh My Zsh is installed
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    if [[ $? -ne 0 ]]; then
        echo "Failed to install Oh My Zsh"
        exit 1
    fi
    echo "Oh My Zsh installed successfully"
else
    echo "Oh My Zsh already installed"
fi

# Set ZSH_CUSTOM if not set
if [[ -z "$ZSH_CUSTOM" ]]; then
    export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
fi

# Install zsh-autosuggestions plugin
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
    echo "Installing zsh-autosuggestions plugin..."
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

    if [[ $? -ne 0 ]]; then
        echo "Failed to install zsh-autosuggestions"
        exit 1
    fi
    echo "zsh-autosuggestions installed successfully"
else
    echo "zsh-autosuggestions already installed"
fi

# Install zsh-vi-mode plugin
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-vi-mode" ]]; then
    echo "Installing zsh-vi-mode plugin..."
    git clone https://github.com/jeffreytse/zsh-vi-mode "$ZSH_CUSTOM/plugins/zsh-vi-mode"

    if [[ $? -ne 0 ]]; then
        echo "Failed to install zsh-vi-mode"
        exit 1
    fi
    echo "zsh-vi-mode installed successfully"
else
    echo "zsh-vi-mode already installed"
fi

# Get the directory - use argument if provided, otherwise use script location
if [[ -n "$1" ]]; then
    SCRIPT_DIR="$1"
else
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
fi
CONFIG_DIR="$(dirname "$SCRIPT_DIR")"

# Create symbolic links
echo "Creating symbolic links..."

# Backup existing .zshrc if it exists and is not a symlink
if [[ -f "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]]; then
    echo "Backing up existing .zshrc to .zshrc.backup"
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi

# Create symlink for .zshrc
if [[ ! -L "$HOME/.zshrc" || "$(readlink "$HOME/.zshrc")" != "$SCRIPT_DIR/.zshrc" ]]; then
    ln -sf "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
    echo "Created symlink for .zshrc"
else
    echo ".zshrc symlink already exists"
fi

# Create symlink for .zsh directory
if [[ ! -L "$HOME/.zsh" || "$(readlink "$HOME/.zsh")" != "$SCRIPT_DIR" ]]; then
    ln -sf "$SCRIPT_DIR" "$HOME/.zsh"
    echo "Created symlink for .zsh directory"
else
    echo ".zsh directory symlink already exists"
fi

# Create local.sh and secrets.sh files if they don't exist
if [[ ! -f "$SCRIPT_DIR/local.sh" ]]; then
    touch "$SCRIPT_DIR/local.sh"
    echo "Created empty local.sh file for machine-specific settings"
fi

if [[ ! -f "$SCRIPT_DIR/secrets.sh" ]]; then
    touch "$SCRIPT_DIR/secrets.sh"
    echo "Created empty secrets.sh file for sensitive information"
fi

echo "Zsh configuration initialized successfully!"
echo "Please restart your shell or run 'source ~/.zshrc' to apply changes"
