local MP = ...
return {
  { import = MP:relpath('fugitive') },
  { import = MP:relpath('gitsigns') },
  { import = MP:relpath('neogit') },
}
