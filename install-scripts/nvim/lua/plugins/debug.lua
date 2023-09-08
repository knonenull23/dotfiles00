return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'mfussenegger/nvim-dap-python',
    'mfussenegger/nvim-jdtls',
    'leoluz/nvim-dap-go'
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_setup = false,
      handlers = {},
      ensure_installed = {
        'javadbg',
        'js',
        'python',
        'bash',
        'chrome',
        'delve'
      }
    }

    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
    vim.keymap.set('n', '<F12>', function()
      require('dap-python').setup()
      require('dap-go').setup {
        dap_configurations = {
          {
            type = "go",
            name = "Attach Remote",
            mode = "remote",
            request = "attach",
            connection = {
              host = "127.0.0.1",
              port = "43000"
            }
          }
        },
        delve = {
          port = "43000"
        }
      }
      Async_load_dap = vim.loop.new_async(vim.schedule_wrap(function()
        local bundles = {
          vim.fn.glob(
            vim.fn.stdpath('data') ..
            "/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
          ),
        }
        vim.list_extend(bundles, vim.split(vim.fn.glob(vim.fn.stdpath('data') .. "/vscode-java-test/server/*.jar"), "\n"))

        require('jdtls').start_or_attach({
          cmd = { 'jdtls' },
          root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
          init_options = {
            bundles = bundles
          },
        })
        require('jdtls').setup_dap({ hotcodereplace = 'auto' })
        vim.defer_fn(function() require('jdtls.dap').setup_dap_main_class_configs() end, 8000)
        Async_load_dap:close()
      end))
      Async_load_dap:send()
    end, { desc = 'Activate Debuggers' })

    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
