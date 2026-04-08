-- display key presses
return {
  'screenkey',
  event = 'VimEnter',
  keys = {
    { '<leader>tsk', '<cmd>Screenkey<CR>', mode = { 'n' }, desc = 'Toggle screenkey' },
  },
  after = function(plugin)
    require('screenkey').setup()
  end,
}
