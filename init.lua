vim.g.mapleader = ';'
vim.g.maplocalleader = ';'
vim.loader.enable() -- bytecode caching

-- See the auto-loaded files in plugin/ for options, keybinds, etc.

require('nixinfo')

nixInfo.lze.load {
  {
    import = "ai",
    category = "ai",
  },
  {
    import = "completion",
    category = "completion",
  },
  {
    import = "debug",
    category = "debug"
  },
  {
    import = "editing",
    category = "editing",
  },
  {
    import = "format",
    category = "format",
  },
  {
    import = "git",
    category = "git",
  },
  {
    import = "markdown",
    category = "lint",
  },
  {
    import = "lint",
    category = "lint",
  },
  {
    import = "lsp",
    category = "lsp",
  },
  {
    import = "search",
    category = "search",
  },
  {
    import = "syntax",
    category = "syntax",
  },
  {
    import = "ui",
    category = "ui",
  },
  {
    import = "wiki",
    category = "wiki",
  },
}
