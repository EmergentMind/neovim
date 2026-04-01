return {
  {
    'vimade',
    event = 'DeferredUIEnter',
    after = function(plugin)
      require('vimade').setup({
        recipe = { 'default', { animate = false } },
        fadelevel = 0.6,
      })
    end,
  },
}
