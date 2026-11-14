vim.opt.autoread = true

-- Tab
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- UI config
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.showmode = false

-- Searching
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- clipboard
vim.opt.clipboard = 'unnamedplus'
vim.keymap.set('v', '<C-c>', '"+y', { noremap = true, silent = true })
vim.keymap.set('n', '<C-v>', '"+p', { noremap = true, silent = true })
vim.keymap.set('i', '<C-v>', '<C-r>+', { noremap = true, silent = true })
vim.keymap.set('c', '<C-v>', '<C-r>+', { noremap = true })
