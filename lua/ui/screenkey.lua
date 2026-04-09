-- display key presses
return {
  'screenkey',
  event = 'VimEnter',
  keys = {
    { '<leader>tsk', '<cmd>Screenkey<CR>', mode = { 'n' }, desc = 'Toggle screenkey' },
  },
  after = function(plugin)
    require('screenkey').setup({
      win_opts = {
        anchor = 'NE',
        row = 1,
        col = vim.o.columns,
      },
    })
  end,
}
