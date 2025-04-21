# Tmux Configuration

This repository contains my personal tmux configuration

## Features

- Vi-style key bindings for pane navigation
- Mouse support enabled
- Extended scrollback history (10,000 lines)
- Clipboard integration with xsel
- Nested session support with F12 toggle
- Plugin support via TPM (Tmux Plugin Manager)

## Key Bindings

### Pane Navigation

- `h` - Move to left pane
- `j` - Move to lower pane
- `k` - Move to upper pane
- `l` - Move to right pane

### Nested Sessions

- `F12` - Toggle between normal and off mode for nested sessions
  - First press: Disables outer tmux bindings
  - Second press: Restores normal mode

## Plugins

This configuration uses [TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm) to manage plugins.

### Installed Plugins

1. [tmux-plugins/tpm](https://github.com/tmux-plugins/tpm) - Plugin manager
2. [IngoMeyer441/tmux-easy-motion](https://github.com/IngoMeyer441/tmux-easy-motion) - Easy motion navigation
   - Prefix key: `\`

## Installation

1. Clone this repository to your home directory:

   ```bash
   git clone <repository-url> ~/config
   ```

2. Install TPM:

   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

3. Create a symbolic link to the tmux configuration:

   ```bash
   ln -s ~/config/tmux/.tmux.conf ~/.tmux.conf
   ```

4. Start tmux and install plugins:
   - Press `prefix + I` (capital i) to install plugins
   - Press `prefix + U` to update plugins

## Status Bar

The status bar includes a visual indicator when in OFF mode (for nested sessions), showing "OFF" in red when outer tmux bindings are disabled.
