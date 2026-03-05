return {
  {
    "nvim-better-n",
    lazy = false,
    after = function(plugin)
      require("better-n").setup({})
    end,
  },
}
