local MP = ...

return {
  -- See introdus for more lsp config
  { import = MP:relpath('postgres') },
  { import = MP:relpath('ts_js') },
}
