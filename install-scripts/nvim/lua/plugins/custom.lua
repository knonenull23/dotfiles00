-- custom keybindings and  added plugins
return {
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      function ToggleSideBar()
        if vim.wo.number == true then
          vim.wo.number = false
          vim.opt.scl = 'no'
        else
          vim.wo.number = true
          vim.opt.scl = 'yes'
        end
      end

      vim.keymap.set('n', '<A-v>e', '<Esc><cmd>e $MYVIMRC<CR>', {})
      vim.keymap.set('n', '<A-v>r', '<Esc><cmd>source $MYVIMRC<CR>', { silent = true })
      vim.keymap.set('n', '<A-t>', '<Esc><cmd>tabnew<CR>', {})
      vim.keymap.set('n', '<A-T>', '<Esc><cmd>terminal<CR>', {})
      vim.keymap.set('n', '<A-w>', '<Esc><cmd>q!<CR>', {})
      vim.keymap.set('t', '<C-d>', '<C-\\><C-n>', {})
      vim.keymap.set('n', '<A-j>', '<C-W>j', {})
      vim.keymap.set('n', '<A-k>', '<C-W>k', {})
      vim.keymap.set('n', '<A-h>', '<C-W>h', {})
      vim.keymap.set('n', '<A-l>', '<C-W>l', {})
      vim.keymap.set('n', '<A-b>', '<cmd>Git blame<CR>', {})
      vim.keymap.set('n', '<A-f>', '<cmd>Format<CR>', {})
      vim.keymap.set('n', '<A-z>', '<cmd>lua ToggleSideBar()<CR>', {})

      vim.keymap.set('n', '<A-1>', '1gt', {})
      vim.keymap.set('n', '<A-2>', '2gt', {})
      vim.keymap.set('n', '<A-3>', '3gt', {})
      vim.keymap.set('n', '<A-4>', '4gt', {})
      vim.keymap.set('n', '<A-5>', '5gt', {})
      vim.keymap.set('n', '<A-6>', '6gt', {})
      vim.keymap.set('n', '<A-7>', '7gt', {})
      vim.keymap.set('n', '<A-8>', '8gt', {})
      vim.keymap.set('n', '<A-9>', '9gt', {})
      vim.keymap.set('n', '<A-<>', '<cmd>tabm -1<CR>', {})
      vim.keymap.set('n', '<A->>', '<cmd>tabm +1<CR>', {})
      vim.keymap.set('t', '<A-1>', '<C-\\><C-n>1gt', {})
      vim.keymap.set('t', '<A-2>', '<C-\\><C-n>2gt', {})
      vim.keymap.set('t', '<A-3>', '<C-\\><C-n>3gt', {})
      vim.keymap.set('t', '<A-4>', '<C-\\><C-n>4gt', {})
      vim.keymap.set('t', '<A-5>', '<C-\\><C-n>5gt', {})
      vim.keymap.set('t', '<A-6>', '<C-\\><C-n>6gt', {})
      vim.keymap.set('t', '<A-7>', '<C-\\><C-n>7gt', {})
      vim.keymap.set('t', '<A-8>', '<C-\\><C-n>8gt', {})
      vim.keymap.set('t', '<A-9>', '<C-\\><C-n>9gt', {})

      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
      vim.keymap.set('n', '<A-q>', '<cmd>NvimTreeToggle<CR>', {})
      require('nvim-tree').setup()
      require('mason-lspconfig').setup(
        {
          ensure_installed = {
            jdtls = {}
          }
        }
      )
    end
  },
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup()
    end
  },
}
