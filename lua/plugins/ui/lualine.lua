return {
  {
    "lualine.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          disabled_filetypes = {
            statusline = { "alpha" },
            winbar = { "alpha" },
          },
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        -- inactive_sections = {
        --   lualine_a = {},
        --   lualine_b = {},
        --   lualine_c = { "filename" },
        --   lualine_x = { "location" },
        --   lualine_y = {},
        --   lualine_z = {},
        -- },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        -- FIXME: what else?
        extensions = { "neo-tree", "trouble", "lazy" },
      })
    end,
  },
}
