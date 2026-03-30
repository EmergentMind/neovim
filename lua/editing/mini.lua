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
        -- flash.nvim uses s/S, so we use m (and remap m to <leader> m)
        -- Think of m like matching (since surrounding chars are matched)
        mappings = {
          add = 'ma', -- Add surrounding in Normal and Visual modes
          delete = 'md', -- Delete surrounding
          find = 'mf', -- Find surrounding (to the right)
          find_left = 'mF', -- Find surrounding (to the left)
          highlight = 'mh', -- Highlight surrounding
          replace = 'mr', -- Replace surrounding
        },
      })
    end,
  },
}
