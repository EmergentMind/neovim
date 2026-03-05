return {
  {
    "postgres_lsp",
    lsp = {
      settings = {
        -- Explicit empty entry like this seems to be needed for it to attach
        postgres_lsp = {}
      },
    },
  },
}
