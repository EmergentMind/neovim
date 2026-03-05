return {
  {
    -- FIXME: this isn't working
    "vim-illuminate",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("vim-illuminate").setup({})
    end
  },
}
