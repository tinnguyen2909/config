# Zsh Configuration

This repository contains my personal zsh configuration setup, built on top of [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh).

## Features

- Customized zsh configuration using Oh My Zsh framework
- Vi-mode support for command line editing
- Smart command suggestions
- Git integration
- Kubernetes command-line tools integration
- Modular configuration structure

## Installation

1. First, install Oh My Zsh:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

2. Clone this repository to your home directory:

```bash
git clone <your-repo-url> ~/config
```

3. Install required plugins:

```bash
# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

# Install zsh-vi-mode
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode
```

4. Create symbolic links:

```bash
ln -s ~/config/zsh/.zshrc ~/.zshrc
ln -s ~/config/zsh ~/.zsh
```

## Configuration Structure

The configuration is split into several files for better organization:

- `.zshrc`: Main configuration file
- `aliases.sh`: Custom command aliases
- `exports.sh`: Environment variables and exports
- `extra.sh`: Additional customizations
- `local.sh`: Machine-specific settings (not tracked by git)
- `secrets.sh`: Sensitive information (not tracked by git)

## Plugins

- **git**: Git integration and aliases
- **kubectl**: Kubernetes command-line tools
- **zsh-autosuggestions**: Smart command suggestions
- **zsh-vi-mode**: Vi-style keybindings for command line

## Customization

You can customize the configuration by:

1. Editing the respective `.sh` files in the `~/.zsh` directory
2. Adding machine-specific settings to `local.sh`
3. Adding sensitive information to `secrets.sh`
