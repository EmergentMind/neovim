return {
  {
    -- FIXME: lsps all need to be reworked and verified
    "pylsp",
    lsp = {
      settings = {
        -- Explicit empty entry like this seems to be needed for it to attach
        pylsp = {}
      },
    },
  },
}
