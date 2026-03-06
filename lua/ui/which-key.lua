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
          { "<leader>a", group = "[a]i" },
          { "<leader>b", group = "[b]uffer" },
          { "<leader>d", group = "[d]ebugger" },
          { "<leader>e", group = "neotree [e]xplorer" },
          { "<leader>f", group = "[f]ind with telescope" },
          { "<leader>g", group = "[g]it" },
          { "<leader>i", group = "[i]nverse value" },
          -- TODO: decide on something other than f or j. j collides with focusing down
          -- once start usiing flash
          -- { "<leader>??", group = "flash jump" },
          { "<leader>l", group = "[l]sp" },
          { "<leader>m", group = "[m]arkdown" },
          { "<leader>o", group = "[o]bsidian" },
          { "<leader>s", group = "[s]earch/replace" },
          { "<leader>u", group = "[u]ndotree" },
          { "<leader>w", group = "[w]iki and window motions" },
          { "<leader>x", group = "quickfi[x] & diagnostics" },
          { "<leader>z", group = "[z]en" },
          { "<leader>F", group = "[F]ormatting" },
          { "<leader><tab>", group = "tabs" },
        },
      })
    end,
  },
}
