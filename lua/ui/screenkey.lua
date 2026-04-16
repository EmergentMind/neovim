-- display key presses
return {
  'screenkey',
  event = 'VimEnter',
  keys = {
    { '<leader>tk', '<cmd>Screenkey<CR>', mode = { 'n' }, desc = '[T]oggle screen[k]ey' },
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
