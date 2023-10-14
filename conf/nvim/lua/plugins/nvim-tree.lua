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
                filters = {
                    dotfiles = false,
                    custom = { '^.git$' }
                },
                disable_netrw = true,
                git = {
                    ignore = true
                },
                view = {
                    width = 50,
                },
                update_focused_file = {
                    enable = true
                },
                renderer = {
                    icons = {
                        show = {
                            file = false,
                            folder = false,
                            folder_arrow = false,
                            git = false,
                            diagnostics = false
                        }
                    }
                }
            })
            vim.keymap.set('n', '<A-f>', '<CMD>Format<CR>', {})
            vim.keymap.set('n', '<A-q>',
                '<CMD>lua ToggleSideBar()<CR><CMD>NvimTreeToggle()<CR><CMD>lua ToggleSideBar()<CR>', {})
            vim.keymap.set('n', '<A-S>', '<CMD>NvimTreeFindFile<CR>', {})
        end
    },

    {
        'stevearc/aerial.nvim',
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require('aerial').setup({
                open_automatic = true,
                on_attach = function(bufnr)
                    -- Jump forwards/backwards with '{' and '}'
                    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
                    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
                end,
                default_direction = "right",
                vim.keymap.set('n', '<A-Q>', '<cmd>AerialToggle!<CR>')
            })
        end
    }
}
