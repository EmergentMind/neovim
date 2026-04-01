local MP = ...

return {
  { import = MP:relpath('postgres') },
  { import = MP:relpath('ts_js') },
}
