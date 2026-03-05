return {
  {
    "ts_ls",
    lsp = {
      filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
      settings = {
        ts_ls = {}
      },
    },
  },
  {
    "ts_query_ls",
    lsp = {
      -- FIXME: Need figure out how to add this block from nix-config:
      -- extraOptions = {
      -- init_options = {
      -- diagnosticSeverity = "Warning";
      -- };
      -- };
      settings = {
      },
    },
  },
}
