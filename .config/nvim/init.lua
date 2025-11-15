-- Set leader key before loading plugins
vim.g.mapleader = ' '

-- Your existing settings
vim.o.number = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.hlsearch = false
vim.o.undofile = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.cursorline = true
vim.wo.relativenumber = true

-- Load plugin manager and plugins (including Aura theme)
require("config.lazy")
