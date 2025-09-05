vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.wrap = false
vim.o.linebreak = true
vim.o.list = true
vim.o.listchars = [[tab:> ,trail:-,nbsp:+]]

vim.o.messagesopt = "hit-enter,history:1000"

-- Auto-reload files when changed outside Neovim
vim.opt.autoread = true
