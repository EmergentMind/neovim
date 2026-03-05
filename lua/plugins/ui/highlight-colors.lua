return {
  {
    "nvim-highlight-colors",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("nvim-highlight-colors").setup({})
    end
  },
}
