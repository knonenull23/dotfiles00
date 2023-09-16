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

      require('nvim-tree').setup({
        view = {
          width = 50
        }
      })
      vim.keymap.set('n', '<A-t>', '<Esc><CMD>tabnew<CR>', {})
      vim.keymap.set('n', '<A-T>', '<Esc><CMD>terminal<CR>', {})
      vim.keymap.set('n', '<A-w>', '<Esc><CMD>q!<CR>', {})
      vim.keymap.set('n', '<A-x>', '<Esc><C-w><C-o>', {})
      vim.keymap.set('t', '<C-d>', '<C-\\><C-n>', {})
      vim.keymap.set('n', '<A-j>', '<C-W>j', {})
      vim.keymap.set('n', '<A-k>', '<C-W>k', {})
      vim.keymap.set('n', '<A-h>', '<C-W>h', {})
      vim.keymap.set('n', '<A-l>', '<C-W>l', {})
      vim.keymap.set('n', '<A-f>', '<CMD>Format<CR>', {})
      vim.keymap.set('n', '<A-z>', '<CMD>lua ToggleSideBar()<CR>', {})
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
      vim.keymap.set('n', '<A-q>', '<CMD>NvimTreeToggle<CR>', {})
      vim.keymap.set('n', '<A-Q>', '<CMD>NvimTreeFindFile<CR>', {})

      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
    end
  }
}
