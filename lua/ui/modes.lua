return {
  'modes',
  event = 'VimEnter',
  after = function(plugin)
    -- Helper to get the hex color of a highlight group
    local function get_hl_hex(hl_name, attr)
      local hl = vim.api.nvim_get_hl(0, { name = hl_name })
      local color = hl[attr] or hl[attr .. 'val']
      if color then
        return string.format('#%06x', color)
      end

      return 'NONE'
    end

    -- `:Telescope highlights` to preview these highlight group names (i.e. string, visual, etc)
    local string_color = get_hl_hex('String', 'fg') -- '#B8BB26'
    local special_comment_color = get_hl_hex('SpecialComment', 'fg') -- '#8F3F71'
    local function_color = get_hl_hex('Function', 'fg') -- '#458588'
    local character_color = get_hl_hex('Character', 'fg') -- '#D05000'
    local constant_color = get_hl_hex('Constant', 'fg') -- '#FE8019'
    local delimeter_color = get_hl_hex('Delimeter', 'fg') -- '#B59B4D'
    local label_color = get_hl_hex('Label', 'fg') -- '#FFCC1B'

    require('modes').setup({
      colors = {
        bg = '', -- Optional bg param, defaults to Normal hl group
        copy = function_color,
        delete = character_color,
        change = constant_color, -- Optional param, defaults to delete
        replace = label_color,
        format = delimeter_color,
        insert = string_color,
        select = special_comment_color,
        visual = special_comment_color,
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
