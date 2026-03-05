return {
  {
    "RRethy/vim-illuminate",
    cmd = {"IlluminatePause", "IlluminateResume", "IlluminateToggle", "IlluminatePauseBuf", "IlluminateResumeBuf", "IlluminateToggleBuf"},
    event = {"BufReadPost","BufNewFile"},
    after = function(plugin)
      require("illuminate").configure({
        providers = {
          'lsp',
          'treesitter',
          'regex',
        }
      })
    end,
  },
}
