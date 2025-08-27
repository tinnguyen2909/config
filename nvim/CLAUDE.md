# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Neovim configuration directory using Lazy.nvim as the plugin manager. The configuration follows a modular structure with separate files for different aspects of the editor setup.

## Architecture

### Core Structure
- `init.lua` - Entry point that loads all configuration modules and sets default colorscheme
- `lua/config/` - Core configuration modules (options, keymaps, autocmds, user commands)
- `lua/plugins/` - Plugin specifications and configurations using Lazy.nvim format

### Plugin Management
- Uses [Lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management
- Plugin specifications are in `lua/plugins/` directory, each returning a table with plugin config
- Plugin versions are locked in `lazy-lock.json`
- Leader key is set to `<Space>`, local leader is `\`

### Key Plugins Installed
- **LSP**: Mason + mason-lspconfig for LSP server management (lua_ls, pyright configured)
- **Completion**: nvim-cmp with multiple sources (LSP, buffer, path, lua)
- **File Navigation**: Neo-tree file explorer, Telescope fuzzy finder
- **Syntax**: Treesitter for syntax highlighting and parsing
- **Themes**: Catppuccin (default), Nightfox available
- **UI**: Which-key for keybinding help, lspkind for completion icons

## Configuration Details

### Editor Settings
- Line numbers: both absolute and relative enabled
- Indentation: 2 spaces, expanded tabs
- Case-insensitive search with smart case
- No line wrapping, but linebreak enabled
- Visible whitespace characters (tabs, trailing spaces)

### File Organization
- Configuration is split into logical modules under `lua/config/`:
  - `options.lua` - Editor options and settings
  - `keymaps.lua` - Custom key mappings (currently minimal)
  - `autocmds.lua` - Autocommands
  - `user-cmds.lua` - User-defined commands
  - `nvim-cmp.lua` - Completion configuration
  - `lazy.lua` - Plugin manager bootstrap and setup

### Plugin Configuration Pattern
Most plugins follow the pattern:
```lua
return {
    'plugin/name',
    dependencies = { ... },
    opts = { ... },  -- or config = function() ... end
}
```

## Common Operations

Since this is a Neovim configuration, most operations involve:
- Adding new plugins by creating files in `lua/plugins/`
- Modifying configuration in `lua/config/` modules
- Testing changes by restarting Neovim or using `:source` commands
- Managing plugin versions through Lazy.nvim interface (`:Lazy`)

When making changes, ensure plugin specifications follow Lazy.nvim conventions and maintain the modular structure.