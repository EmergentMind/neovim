-- NOTE: lots of these are overriding introdus defaults
--
-- Store lots of :cmdline
-- vim.opt.history = 1000

-- ================ Wrapping and Line Breaks ========================
-- vim.opt.wrap = false
-- Wrap lines at convenient points
-- vim.opt.linebreak = true
-- vim.opt.textwidth = 80

-- ================ Indentation ======================
-- automatically indent braces
vim.opt.cindent = true

-- ================ Scrolling ========================
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.sidescrolloff = 10
vim.opt.sidescroll = 1

-- ================ Movement ========================
-- allow backspace in insert mode
vim.opt.backspace = 'indent,eol,start'

-- ========= Redirect Temp Files =========
-- backup
vim.opt.backupdir = '$HOME/.vim/backup//,/tmp//,.'
vim.opt.writebackup = false
-- swap
vim.opt.directory = '$HOME/.vim/swap//,/tmp//,.'

-- if vim.g.neovide then
--   -- When using rounded borders lualine/tabs clip
--   vim.g.neovide_padding_top = 4
--   vim.g.neovide_padding_bottom = 0
--   vim.g.neovide_padding_right = 2
--   vim.g.neovide_padding_left = 7
-- end

-- NOTE: trying with this off for a bit
-- ================ Persistent Undo ==================
-- Keep undo history across sessions, by storing in file.
-- See also lua/plugins/editing/atone.lua
-- if vim.fn.has('persistent_undo') == 1 then
--   local undo_dir = vim.fn.expand('~/.vim/backups')
--   -- Create the directory if it doesn't exist;
--   if vim.fn.isdirectory(undo_dir) == 0 then
--     vim.fn.mkdir(undo_dir, 'p')
--   end
--   vim.opt.undodir = undo_dir
-- end
