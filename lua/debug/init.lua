return {
  {
    "nvim-dap",
    -- NOTE: I dont want to figure out mason tools installer for this, so I only enabled debug if nix loaded config
    for_cat = 'debug',
    -- cmd = { "" },
    -- event = "",
    -- ft = "",
    keys = {
      { "<F1>",       desc = "DAP: Start/Continue" },
      { "<F2>",       desc = "DAP: Step Into" },
      { "<F3>",       desc = "DAP: Step Over" },
      { "<F4>",       desc = "DAP: Step Out" },
      { "<F5>",       desc = "DAP: Step Back" },
      { "<leader>bb", desc = "DAP: Toggle Breakpoint" },
      { "<leader>bB", desc = "DAP: Set Breakpoint" },
      { "<leader>br", desc = "DAP: Run to cursor" },
      { "<leader>blp", desc = "DAP: Log point message:" },
      { "<leader>bu", desc = "DAP: Toggle DAP-UI" },
      { "<leader>bh", desc = "DAP: Hover widgets" },
      { "<leader>bp", desc = "DAP: Preview widgets" },
      { "<F7>",       desc = "DAP: See last session result." },
    },
    -- colorscheme = "",
    load = (nixInfo.isNix and function(name)
      vim.cmd.packadd(name)
      vim.cmd.packadd("nvim-dap-ui")
      vim.cmd.packadd("nvim-dap-virtual-text")
    end) or function(name)
      vim.cmd.packadd(name)
      vim.cmd.packadd("nvim-dap-ui")
      vim.cmd.packadd("nvim-dap-virtual-text")
      vim.cmd.packadd("mason-nvim-dap.nvim")
    end,
    after = function(plugin)
      local map = vim.keymap.set

      local dap = require 'dap'
      local dapui = require 'dapui'

      -- Basic debugging keymaps, feel free to change to your liking!
      map('n', '<F1>', dap.continue, { desc = 'DAP: Start/Continue' })
      map('n', '<F2', dap.step_into, { desc = 'DAP: Step Into' })
      map('n', '<F3>', dap.step_over, { desc = 'DAP: Step Over' })
      map('n', '<F4>', dap.step_out, { desc = 'DAP: Step Out' })
      map('n', '<F5>', dap.step_back, { desc = 'DAP: Step Back' })
      map('n', '<F12>', dap.restart, { desc = 'DAP: Restart' })
      map('n', '<leader>bb', dap.toggle_breakpoint, { desc = 'DAP: Toggle Breakpoint' })
      map('n', '<leader>bB', dap.set_breakpoint, { desc = 'DAP: Set Breakpoint' })
      map('n', '<leader>blp', function()
        dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message:')
      end, { desc = 'DAP: Log Point' })
      map('n', '<leader>br', dap.run_to_cursor, { desc = 'DAP: Run to Cursor' })

      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      map('n', '<leader>bu', dapui.toggle, { desc = 'DAP: See last session result.' })
      map('n', '<leader>bh', dapui.widgets.hover, { desc = 'DAP: Hover widgets' })
      map('n', '<leader>bp', dapui.widgets.preview, { desc = 'DAP: Preview widgets' })

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup {
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
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

      require("nvim-dap-virtual-text").setup {
        enabled = true,                     -- enable this plugin (the default)
        enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = false,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true,            -- show stop reason when stopped for exceptions
        commented = false,                  -- prefix virtual text with comment string
        only_first_definition = true,       -- only show virtual text at first definition (if there are multiple)
        all_references = false,             -- show virtual text on all all references of the variable (not only definitions)
        clear_on_continue = false,          -- clear virtual text on "continue" (might cause flickering when stepping)
        --- A callback that determines how a variable is displayed or whether it should be omitted
        --- variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
        --- buf number
        --- stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
        --- node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
        --- options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
        --- string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
        display_callback = function(variable, options)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)

          if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
            return "******"
          end

          if value > 15 then
            return " " .. string.sub(value, 1, 15) .. "... "
          else
            return " " .. value
          end

          -- FIXME: this was from template... may be useful
          -- if options.virt_text_pos == 'inline' then
          --   return ' = ' .. value
          -- else
          --   return name .. ' = ' .. variable.value
          -- end
        end,
        -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
        virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

        -- experimental features:
        all_frames = false,     -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false,     -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
      }

      -- NOTE: Install lang specific config
      -- either in here, or in a separate plugin spec as demonstrated for go below.
    end,
  },
  {
    "nvim-dap-go",
    for_cat = { cat = 'debug', default = false },
    on_plugin = { "nvim-dap", },
  },
  {
    "nvim-dap-lldb",
    for_cat = { cat = 'debug', default = false },
    on_plugin = { "nvim-dap", },
  },
  {
    "nvim-dap-python",
    for_cat = { cat = 'debug', default = false },
    on_plugin = { "nvim-dap", },
  },
}
