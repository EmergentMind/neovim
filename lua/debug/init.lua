return {
  {
    "nvim-dap",
    event = "VimEnter",
    cmd = {
      "DapToggleBreakpoint",
      "DapClearBreakpoints",
      "DapNew",
      "DapStepInto",
      "DapPause",
      "DapContinue",
      "DapStepOut",
      "DapStepOver",
      "DapSetLogLevel",
      "DapShowLog",
    },
    keys = {
      { "<F1>", desc = "DAP: Start/Continue" },
      { "<F2>", desc = "DAP: Step Into" },
      { "<F3>", desc = "DAP: Step Over" },
      { "<F4>", desc = "DAP: Step Out" },
      { "<F5>", desc = "DAP: Step Back" },
      { "<F7>", desc = "DAP: Step Last" },
      { "<F12>", desc = "DAP: Restart" },
      { "<leader>db", desc = "DAP: Toggle Breakpoint" },
      { "<leader>dB", desc = "DAP: Set Breakpoint" },
      { "<leader>dr", desc = "DAP: Run to cursor" },
      { "<leader>du", desc = "DAP: Toggle DAP-UI" },
      { "<leader>dh", desc = "DAP: Hover widgets" },
      { "<leader>dp", desc = "DAP: Preview widgets" },
      { "<leader>ds", desc = "DAP: Widget scopes" },
    },
    dependencies = {
      "nvim-dap-ui",
      "nvim-dap-virtual-text",
      "nvim-dap-python",
      "nvim-dap-lldb",
    },
    after = function(plugin)
      local dap = require("dap")
      local dapui = require("dapui")

      vim.keymap.set("n", "<F1>", dap.continue, { desc = "DAP: Start/Continue" })
      vim.keymap.set("n", "<F2>", dap.step_into, { desc = "DAP: Step Into" })
      vim.keymap.set("n", "<F3>", dap.step_over, { desc = "DAP: Step Over" })
      vim.keymap.set("n", "<F4>", dap.step_out, { desc = "DAP: Step Out" })
      vim.keymap.set("n", "<F5>", dap.step_back, { desc = "DAP: Step Back" })
      vim.keymap.set("n", "<F7>", dap.step_back, { desc = "DAP: Step Last" })
      vim.keymap.set("n", "<F12>", dap.restart, { desc = "DAP: Restart" })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Debug: Set Breakpoint" })
      vim.keymap.set("n", "<leader>dr", dap.run_to_cursor, { desc = "DAP: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP: Toggle DAP-UI" })
      vim.keymap.set("n", "<leader>dh", dapui.widgets.hover, { desc = "DAP: Hover widgets" })
      vim.keymap.set("n", "<leader>dp", dapui.widgets.preview, { desc = "DAP: Preview widgets" })
      vim.keymap.set("n", "<leader>ds", dapui.widgets.scopes, { desc = "DAP: Widget scopes" })

      dap.listeners.before.attach["dapui_config"] = dapui.open
      dap.listeners.before.launch["dapui_config"] = dapui.open
      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close

      -- FIXME: need something nicer?
      vim.fn.sign_define("DapBreakpoint", { text = "🔴" })

      -- DAP UI
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
        controls = {
          icons = {
            pause = "⏸",
            play = "▶",
            step_into = "⏎",
            step_over = "⏭",
            step_out = "⏮",
            step_back = "b",
            run_last = "▶▶",
            terminate = "⏹",
            disconnect = "⏏",
          },
        },
      })

      require("nvim-dap-virtual-text").setup({
        -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
            return "*****"
          end

          if #variable.value > 15 then
            return " " .. string.sub(variable.value, 1, 15) .. "... "
          end

          return " " .. variable.value
        end,
      })

      dap.configurations = {
        c = {
          name = "Launch lldb Debugger",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }
    end,
  },
}
