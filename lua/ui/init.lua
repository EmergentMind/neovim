local MP = ...
return {
  -- Primary colorscheme
  { import = MP:relpath('mini-base16') },

  { import = MP:relpath('hardtime') },
  { import = MP:relpath('highlight-colors') },
  { import = MP:relpath('lualine') },
  { import = MP:relpath('neo-tree') },
  { import = MP:relpath('notify') },
  { import = MP:relpath('nvim-numbertoggle') },
  { import = MP:relpath('screenkey') },
  { import = MP:relpath('snacks') },
  { import = MP:relpath('tabby') },
  { import = MP:relpath('toggleterm') },
  { import = MP:relpath('trouble') },
  { import = MP:relpath('ufo') },
  { import = MP:relpath('which-key') },
}
