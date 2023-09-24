return {
    'tpope/vim-rhubarb',
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set('n', '<leader>g', '<CMD>Git<CR>', {})
            vim.keymap.set('n', '<leader>gl', '<CMD>Git log -p --follow %<CR>', {})
            vim.keymap.set('n', '<leader>gL', '<CMD>Git log<CR>', {})
            vim.keymap.set('n', '<leader>gd', '<CMD>Git diff<CR>', {})
            vim.keymap.set('n', '<leader>gs', '<CMD>Gvdiffsplit<CR>', {})
            vim.keymap.set('n', '<leader>gb', '<CMD>Git blame<CR>', {})
            vim.keymap.set('n', '<leader>gp', '<CMD>Git push<CR>', {})
            vim.keymap.set('n', '<leader>gx', '<CMD>Git remote prune origin<CR>', {})
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
            require('oil').setup({
                columns = {
                    "permissions",
                    "size"
                }
            })
            vim.keymap.set("n", '-', '<CMD>Oil --float ' .. vim.fn.expand('%') .. '<CR>',
                { desc = "Open parent directory" })
            vim.keymap.set("n", '<leader>-', '<CMD>Oil --float ' .. vim.fn.stdpath('config') .. '<CR>',
                { desc = "Edit configuration folder" })
        end
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            require('toggleterm').setup()
            vim.keymap.set("n", '<leader>`', '<CMD>ToggleTerm<CR>', { desc = "Terminal" })
            vim.keymap.set("t", '<leader>`', '<Esc><CMD>ToggleTerm<CR>', { desc = "Terminal" })
        end
    }
}
