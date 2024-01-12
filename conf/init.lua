-- config folder: $HOME/.config/nvim OR $HOME\AppData\Local\nvim
-- requires ripgrep, npm, git, node, python, cmake, gcc, clangd
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
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { 'lua', 'python', 'tsx', 'javascript', 'typescript', 'java' },
                auto_install = false,
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<c-space>',
                        node_incremental = '<c-space>',
                        scope_incremental = '<c-s>',
                        node_decremental = '<M-space>',
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['aa'] = '@parameter.outer',
                            ['ia'] = '@parameter.inner',
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer',
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer',
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ['<leader>a'] = '@parameter.inner',
                        },
                        swap_previous = {
                            ['<leader>A'] = '@parameter.inner',
                        },
                    },
                },
            }
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build =
                'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
                cond = function()
                    return vim.fn.executable 'cmake' == 1
                end,
            },
        },
        config = function()
            require('telescope').setup {
                pickers = {
                    find_files = {
                        hidden = true
                    }
                },
                defaults = {
                    mappings = {
                        i = {
                            ['<C-u>'] = false,
                            ['<C-d>'] = false,
                        },
                    },
                },
            }
            pcall(require('telescope').load_extension, 'fzf')
            vim.keymap.set('n', '<C-b>', require('telescope.builtin').buffers,
                { desc = '[ ] Find existing buffers' })

            vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files,
                { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<C-h>', require('telescope.builtin').help_tags,
                { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<C-f>', require('telescope.builtin').live_grep,
                { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<C-g>', require('telescope.builtin').diagnostics,
                { desc = '[S]earch [D]iagnostics' })
        end
    },
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
            vim.keymap.set('n', '<A-q>',
                '<CMD>lua ToggleSideBar()<CR><CMD>NvimTreeToggle()<CR><CMD>lua ToggleSideBar()<CR><CR>',
                {})
            vim.keymap.set('n', '<A-Q>', '<CMD>NvimTreeFindFile<CR>', {})
        end
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            require('toggleterm').setup()
            vim.keymap.set("n", '<A-t>', '<CMD>ToggleTerm<CR>', { desc = "Terminal" })
            vim.keymap.set("t", '<A-t>', '<Esc><CMD>ToggleTerm<CR>', { desc = "Terminal" })
            vim.keymap.set("n", '<A-e>', '<Esc><CMD>ToggleTermSendCurrentLine<CR>', {})
            vim.keymap.set("v", '<A-e>', '<Esc><CMD>ToggleTermSendVisualLines<CR>', {})
            if vim.loop.os_uname().sysname == 'Windows' or vim.loop.os_uname().sysname == 'Windows_NT' then
                vim.keymap.set("n", '<A-r>', '<Esc><CMD>TermExec cmd="Invoke-History"<CR>',
                    { desc = "Run previous command in terminal" })
            else
                vim.keymap.set("n", '<A-r>', '<Esc><CMD>TermExec cmd="!!"<CR>',
                    { desc = "Run previous command in terminal" })
            end
        end
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
        },
        config = function()
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
                { desc = 'Go to previous diagnostic message' })
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
            vim.keymap.set('n', '[[', vim.diagnostic.open_float,
                { desc = 'Open floating diagnostic message' })
            vim.keymap.set('n', ']]', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
            vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

            local on_attach = function(_, bufnr)
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end
                    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
                end
                nmap('rn', vim.lsp.buf.rename, '[R]e[n]ame')
                nmap('ga', vim.lsp.buf.code_action, '[C]ode [A]ction')
                nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
                nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                nmap('gT', vim.lsp.buf.type_definition, 'Type [D]efinition')
                nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
                nmap('gk', vim.lsp.buf.hover, 'Hover Documentation')
                vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                    vim.lsp.buf.format()
                end, { desc = 'Format current buffer with LSP' })
            end
            local mason_lspconfig = require 'mason-lspconfig'

            local servers = {}

            servers['lua_ls'] = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                    diagnostics = {
                        globals = {
                            'vim',
                            'require'
                        }
                    }
                },
            }

            servers['yamlls'] = {
                yaml = {
                    schemas = {
                        kubernetes = "*.k8s.yaml",
                        ['https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json'] =
                        "*.cf.yaml"
                    }
                }
            }

            if vim.fn.executable 'python' == 1 then
                servers['pyright'] = {}
            end

            if vim.fn.executable 'bash' == 1 then
                servers['bashls'] = {}
            end

            if vim.fn.executable 'clangd' == 1 then
                servers['clangd'] = {}
            end

            mason_lspconfig.setup {
                ensure_installed = vim.tbl_keys(servers),
            }

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            mason_lspconfig.setup_handlers {
                function(server_name)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                        cmd = (servers[server_name] or {}).cmd,
                    }
                end
            }
            require "lsp_signature".on_attach()
        end
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            luasnip.config.setup {}

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert {
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete {},
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                },
            }
        end
    },
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
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
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = false,
                theme = 'auto',
                component_separators = '|',
                section_separators = '',
            },
        },
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        config = function()
            require('lsp_signature').setup {
            }
        end
    },
    {
        'gelguy/wilder.nvim',
        config = function()
            local wilder = require('wilder')
            wilder.setup({ modes = { ':', '/', '?' } })
            wilder.set_option('pipeline', {
                wilder.branch(
                    wilder.cmdline_pipeline(),
                    wilder.search_pipeline()
                ),
            })
            wilder.set_option('renderer', wilder.wildmenu_renderer({
                highlighter = wilder.basic_highlighter(),
            }))
        end
    },
    {
        'tpope/vim-fugitive'
    },
    {
        "joshdick/onedark.vim"
    },
    {
        'rafamadriz/friendly-snippets',
    }
}, {})

vim.cmd [[colorscheme onedark]]
vim.o.hlsearch = true
vim.wo.number = false
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
vim.o.timeoutlen = 250
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.opt.path = vim.opt.path + { vim.fn.stdpath('data') .. 'mason/bin' }
vim.o.foldmethod = 'indent'
vim.o.foldlevelstart = 99
vim.o.foldnestmax = 2;
vim.o.foldminlines = 0;

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {})
vim.keymap.set('n', '<A-n>', '<Esc><CMD>tabnew<CR>', {})
vim.keymap.set('n', '<A-w>', '<Esc><CMD>q!<CR>', {})
vim.keymap.set('v', '<A-d>', '"_d', {})
vim.keymap.set('n', '<A-d>', '"_dd', {})
vim.keymap.set('n', '<A-j>', '<C-W>j', {})
vim.keymap.set('n', '<A-k>', '<C-W>k', {})
vim.keymap.set('n', '<A-h>', '<C-W>h', {})
vim.keymap.set('n', '<A-l>', '<C-W>l', {})
vim.keymap.set('t', '<A-j>', '<C-\\><C-n><C-w>j', {})
vim.keymap.set('t', '<A-k>', '<C-\\><C-n><C-w>k', {})
vim.keymap.set('t', '<A-h>', '<C-\\><C-n><C-w>h', {})
vim.keymap.set('t', '<A-l>', '<C-\\><C-n><C-w>l', {})
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
vim.keymap.set('n', '<F1>', '<CMD>diffget LOCAL<CR>', {})
vim.keymap.set('n', '<F2>', '<CMD>diffget BASE<CR>', {})
vim.keymap.set('n', '<F3>', '<CMD>diffget REMOTE<CR>', {})
vim.keymap.set('n', '<F4>', ':%s/<c-r>+/<c-r>+/gc<c-f>$F/i', {})

-- useful CLI
-- delete branches except currently checked out: git branch -D (git branch --list --format "%(refname:short)")
