return {
  {
    "range-highlight.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("range-highlight").setup({})
    end,
  },
}
