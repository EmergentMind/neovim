return {
  {
    "pylsp",
    lsp = {
      filetypes = { "python" },
      root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        ".git",
      },
      settings = {
        pylsp = {},
      },
    },
  },
}
