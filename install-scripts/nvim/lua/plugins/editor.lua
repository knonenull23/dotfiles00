return {
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',
  { 
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set("n", '=', '<CMD>G<CR>', { desc = "Git" })
    end
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },

  {
    'folke/neodev.nvim',
    config = function()
      require('neodev').setup({})
    end
  },

  {
    'folke/tokyonight.nvim',
    priority = 1000,
    lazy = false,
    opts = {}
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'tokyonight',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup()
      vim.keymap.set("n", '-', '<CMD>Oil --float ' .. vim.fn.expand('%') .. '<CR>', { desc = "Open parent directory" })
      vim.keymap.set("n", '<leader>-', '<CMD>Oil --float ' .. vim.fn.stdpath('config') .. '<CR>', { desc = "Edit configuration folder" })
    end
  },
}
