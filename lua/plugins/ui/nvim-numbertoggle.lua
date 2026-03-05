return {
  {
    "nvim-numbertoggle",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("nvim-numbertoggle").setup({})
    end,
  },
}
