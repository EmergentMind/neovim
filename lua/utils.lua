local M = {}

-- Some utils found here: https://github.com/theherk/commons/blob/main/.config/nvim/lua/module/util.lua
-- via this neovide discussion: https://github.com/neovide/neovide/discussions/2891
function M.set_cursor_colors(colors)
  vim.api.nvim_set_hl(0, "Cursor", { bg = #FE8019, fg = "black" })
  vim.api.nvim_set_hl(0, "TermCursor", { bg = #FE8019, fg = "black" })
end

-- -- Override cursor color and blink for nav and visual mode
-- vim.cmd([[highlight Cursor guifg=#000000 guibg=#FE8019]])
-- -- Override cursor color for insert mode
-- vim.cmd([[highlight iCursor guifg=#000000 guibg=#FE8019]])

-- This is bespoke to catppuccin at the moment, but should be expanded.
function M.set_term_colors(colors)
  vim.g.terminal_color_0 = colors.surface1
  vim.g.terminal_color_1 = colors.red
  vim.g.terminal_color_2 = colors.green
  vim.g.terminal_color_3 = colors.yellow
  vim.g.terminal_color_4 = colors.blue
  vim.g.terminal_color_5 = colors.pink
  vim.g.terminal_color_6 = colors.teal
  vim.g.terminal_color_7 = colors.subtext1
  vim.g.terminal_color_8 = colors.surface2
  vim.g.terminal_color_9 = colors.red
  vim.g.terminal_color_10 = colors.green
  vim.g.terminal_color_11 = colors.yellow
  vim.g.terminal_color_12 = colors.blue
  vim.g.terminal_color_13 = colors.pink
  vim.g.terminal_color_14 = colors.teal
  vim.g.terminal_color_15 = colors.subtext0
end

return M
