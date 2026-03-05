return {
  -- {
  --   "fidget.nvim",
  --   event = "LspAttach",
  --   after = function(plugin)
  --     require("fidget").setup({})
  --   end,
  -- },
  {
    "nvim-notify",
    priority = 1000,
    after = function(plugin)
      local notify = require("notify")
      notify.setup({
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { focusable = false })
        end,
        -- Avoid warning when using transparency
        background_colour = "#212F3D",
      })
      vim.notify = notify
      vim.keymap.set("n", "<Esc>", function()
        notify.dismiss({ silent = true, })
      end, { desc = "Dismiss notify popup and clear hlsearch" })
    end,
  },
  {
    "noice.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          -- Conflicts with blink
          signature = { enabled = false, },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = true,
        },
        routes = {
          {
            filter = {
              event = "msg_show",
              kind = "",
              find = "written",
            },
            opts = { skip = true },
          },
        },
      })
    end,
  },
}
