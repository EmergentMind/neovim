return {
  {
    "which-key.nvim",
    event = "DeferredUIEnter",
    after = function(name)
      require("which-key").setup({
        preset = "modern",
        delay = 150,
        icons = {
          mappings = true,
          keys = {},
        },
        spec = {
          { "<leader>a", group = "agents/avante" },
          { "<leader>b", group = "breakpoints/debugger" },
          { "<leader>c", group = "code and line diagnostics" },
          { "<leader>e", group = "neotree" },
          { "<leader>f", group = "telescope" },
          { "<leader>g", group = "git and LSP" },
          { "<leader>m", group = "markdown" },
          { "<leader>n", group = "flash nav" },
          { "<leader>p", group = "pairs" },
          { "<leader>s", group = "search/replace" },
          { "<leader>t", group = "treesitter" },
          { "<leader>u", group = "undotree" },
          { "<leader>w", group = "wiki and workspaces" },
          { "<leader>x", group = "trouble diagnostics & quickfix list" },
          { "<leader>z", group = "folds/zen" },
        },
      })
    end,
  },
}
