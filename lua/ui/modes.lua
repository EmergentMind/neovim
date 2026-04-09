return {
  'modes',
  event = 'VimEnter',
  after = function(plugin)
    require('modes').setup({
      colors = {
        bg = '', -- Optional bg param, defaults to Normal hl group
        copy = '#458588',
        delete = '#D05000',
        change = '#FFCC1B', -- Optional param, defaults to delete
        format = '#B59B4D',
        insert = '#B8BB26',
        replace = '#245361',
        select = '#8F3F71', -- Optional param, defaults to visual
        visual = '#8F3F71',
      },

      -- Set opacity for cursorline and number background
      line_opacity = 0.15,

      -- Enable cursor highlights
      set_cursor = true,

      -- Enable cursorline initially, and disable cursorline for inactive windows
      -- or ignored filetypes
      set_cursorline = true,

      -- Enable line number highlights to match cursorline
      set_number = true,

      -- Enable sign column highlights to match cursorline
      set_signcolumn = true,

      -- Disable modes highlights for specified filetypes
      -- or enable with prefix "!" if otherwise disabled (please PR common patterns)
      -- Can also be a function fun():boolean that disables modes highlights when true
      ignore = { 'NvimTree', 'TelescopePrompt', '!minifiles' },
    })
  end,
}
