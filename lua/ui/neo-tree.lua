return {
  {
    "neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      { "<leader>ee", "<cmd>Neotree toggle reveal_force_cwd<cr>", mode = { "n" }, desc = "File explorer (cwd)" },
      { "<leader>eE", "<cmd>Neotree toggle<cr>", mode = { "n" }, desc = "File explorer" },
      { "<leader>eb", "<cmd>Neotree buffers<cr>", mode = { "n" }, desc = "Buffer explorer" },
      { "<leader>eg", "<cmd>Neotree git_status<cr>", mode = { "n" }, desc = "Git explorer" },
    },
    after = function(plugin)
      require("neo-tree").setup({
        event_handlers = {
          {
            event = "neo_tree_buffer_enter",
            handler = function(arg)
              vim.cmd([[ setlocal relativenumber ]])
            end,
          },
        },
        enable_git_status = true,
        enable_modified_markers = true,
        enable_refresh_on_write = true,
        close_if_last_window = false,
        popup_border_style = "rounded",

        -- -- FIXME: some of these are likely superfluous
        default_component_configs = {
          indent = {
            indent_size = 2,
            padding = 1,
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
          },
          --   git_status = {
          --     symbols = {
          --       -- consistent with starship git_status
          --       added     = "+",
          --       modified  = "!",
          --       deleted   = "-",
          --       renamed   = "r",
          --       untracked = "?",
          --       ignored   = "",
          --       unstaged  = "󰄱",
          --       staged    = "+",
          --       conflict  = "~",
          --     },
          --   },
        },
        buffers = {
          bind_to_cwd = false,
          follow_current_file = {
            enabled = true,
          },
        },
        window = {
          position = "left",
          width = 40,
          -- auto_expand_width = false,
        },
      })
    end,
  },
}
