-- FIXME: investigate other mini tools
return {
  {
    "mini.nvim",
    auto_enable = true,
    event = "DeferredUIEnter",
    after = function(name)
      require("mini.ai").setup()
      require("mini.comment").setup()
      require("mini.pairs").setup()
      -- FIXME: surround interferes with `s` and needs some tweaking
      -- or get used to using r instead of s for old use
      require("mini.surround").setup({})
      --   add = "<leader>sa",
      --   delete = "<leader>sd",
      --   find = "<leader>sf",
      --   find_left = "<leader>sF",
      --   highlight = "<leader>sh",
      --   replace = "<leader>sr",
      --   suffix_last = "<leader>sl",
      --   suffix_next = "<leader>sn",
      -- })
    end,
  },
}
