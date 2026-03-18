local MP = ...
return {
  -- Primary colorscheme
  { import = MP:relpath('mini-base16') },

  { import = MP:relpath('confirm-quit') },
  { import = MP:relpath('hardtime') },
  { import = MP:relpath('highlight-colors') },
  { import = MP:relpath('lualine') },
  { import = MP:relpath('neo-tree') },
  { import = MP:relpath('noice') },
  { import = MP:relpath('notify') },
  { import = MP:relpath('nvim-numbertoggle') },
  { import = MP:relpath('range-highlight') },
  { import = MP:relpath('smart-splits') },
  { import = MP:relpath('snacks') },
  -- FIXME: enable this and setup
  -- { import = MP:relpath('toggleterm') },
  { import = MP:relpath('trouble') },
  { import = MP:relpath('ufo') },
  { import = MP:relpath('vimade') },
  { import = MP:relpath('which-key') },
  { import = MP:relpath('zen-mode') },
}
