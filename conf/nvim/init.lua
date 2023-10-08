-- config folder: $HOME/.config/nvim
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    require 'plugins.editor',
    require 'plugins.lsp',
    require 'plugins.telescope',
    require 'plugins.treesitter',
    require 'plugins.debug',
    require 'plugins.nvim-tree',
    require 'plugins.chatgpt'
}, {})

vim.cmd [[colorscheme tokyonight]]
vim.o.hlsearch = true
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smarttab = true
vim.o.expandtab = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 200
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.opt.path = vim.opt.path + { vim.fn.stdpath('data') .. 'mason/bin' }
vim.o.foldmethod = 'indent'
vim.o.foldlevelstart = 99
vim.o.foldnestmax = 2;
vim.o.foldminlines = 0;

function ToggleSideBar()
    if vim.wo.number == true then
        vim.wo.number = false
        vim.opt.scl = 'no'
    else
        vim.wo.number = true
        vim.opt.scl = 'yes'
    end
end

vim.keymap.set("n", '<leader>q', 'za', { desc = "Fold" })
vim.keymap.set('n', '<A-n>', '<Esc><CMD>tabnew<CR>', {})
vim.keymap.set('n', '<A-t>', '<Esc><CMD>terminal<CR>', {})
vim.keymap.set('n', '<A-w>', '<Esc><CMD>q!<CR>', {})
vim.keymap.set('n', '<A-x>', '<Esc><C-w>T<CR>', {})
vim.keymap.set('n', '<A-X>', '<Esc><C-w><C-o>', {})
vim.keymap.set('v', '<A-d>', '"_d', {})
vim.keymap.set('n', '<A-d>', '"_dd', {})
vim.keymap.set('t', '<C-d>', '<C-\\><C-n>', {})
vim.keymap.set('n', '<A-j>', '<C-W>j', {})
vim.keymap.set('n', '<A-k>', '<C-W>k', {})
vim.keymap.set('n', '<A-h>', '<C-W>h', {})
vim.keymap.set('n', '<A-l>', '<C-W>l', {})
vim.keymap.set('n', '<A-1>', '1gt', {})
vim.keymap.set('n', '<A-2>', '2gt', {})
vim.keymap.set('n', '<A-3>', '3gt', {})
vim.keymap.set('n', '<A-4>', '4gt', {})
vim.keymap.set('n', '<A-5>', '5gt', {})
vim.keymap.set('n', '<A-6>', '6gt', {})
vim.keymap.set('n', '<A-7>', '7gt', {})
vim.keymap.set('n', '<A-8>', '8gt', {})
vim.keymap.set('n', '<A-9>', '9gt', {})
vim.keymap.set('n', '<A-<>', '<CMD>tabm -1<CR>', {})
vim.keymap.set('n', '<A->>', '<CMD>tabm +1<CR>', {})
vim.keymap.set('t', '<A-1>', '<C-\\><C-n>1gt', {})
vim.keymap.set('t', '<A-2>', '<C-\\><C-n>2gt', {})
vim.keymap.set('t', '<A-3>', '<C-\\><C-n>3gt', {})
vim.keymap.set('t', '<A-4>', '<C-\\><C-n>4gt', {})
vim.keymap.set('t', '<A-5>', '<C-\\><C-n>5gt', {})
vim.keymap.set('t', '<A-6>', '<C-\\><C-n>6gt', {})
vim.keymap.set('t', '<A-7>', '<C-\\><C-n>7gt', {})
vim.keymap.set('t', '<A-8>', '<C-\\><C-n>8gt', {})
vim.keymap.set('t', '<A-9>', '<C-\\><C-n>9gt', {})
vim.keymap.set('i', '<C-f>', '<C-x><C-f>', {})
vim.keymap.set('n', '<F4>', ':%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i', {})
