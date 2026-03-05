return {
  {
    "mini.nvim",
    auto_enable = true,
    event = "DeferredUIEnter",
    after = function(name)
      --FIXME: Pick a few of these to start and then TODO the rest for
      --future self
      require("mini.ai").setup()
      require("mini.comment").setup()
      require("mini.pairs").setup()
      -- FIXME: this interferes with `s` and needs some tweaking
      -- require("mini.surround").setup({})
    end
  },
}
