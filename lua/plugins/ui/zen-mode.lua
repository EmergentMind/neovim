return {
  {
    "zen-mode.nvim",
    event = "DeferredUIEnter",
    keys = {
      { "<leader>zz", "<cmd>ZenMode<cr>", mode = { "n" }, desc = "Toggle Zen-Mode" },
    },
    after = function(plugin)
      require("zen-mode").setup({})
    end,
  },
}
