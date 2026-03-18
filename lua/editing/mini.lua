return {
  {
    'mini.nvim',
    auto_enable = true,
    event = 'DeferredUIEnter',
    after = function(name)
      require('mini.ai').setup()
      require('mini.comment').setup()
      --NOTE: flash.nvim uses s/S, so we use m (and remap m to <leader> m)
      -- Think of m like matching (since surrounding chars are matched)
      require('mini.surround').setup({
        add = 'ma',
        delete = 'md',
        find = 'mf',
        find_left = 'mF',
        highlight = 'mh',
        replace = 'mr',
        suffix_last = 'ml',
        suffix_next = 'mn',
      })
    end,
  },
}
