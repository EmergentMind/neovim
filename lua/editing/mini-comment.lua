return {
  {
    'mini.comment',
    auto_enable = true,
    event = 'DeferredUIEnter',
    after = function(name)
      require('mini.comment').setup()
    end,
  },
}
