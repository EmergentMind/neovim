--
-- ================ Options ========================
--
local opt = vim.opt
local fn = vim.fn

-- ================ General Appearance ========================
opt.hidden = true
-- show relative linenumbers
opt.relativenumber = true
-- display status line always
opt.laststatus = 0
-- Store lots of :cmdline
opt.history = 1000
-- Show current mode down the bottom
opt.showmode = true
-- Reload files changed outside vim
opt.autoread = true
-- Highlight matching braces
opt.showmatch = true

-- ================ Basic Completion =======================
-- FIXME: Disabling the wild options for now since they may be conflicting with other settings
-- opt.wildmode = 'list:longest,list:full' -- for tab completion in : command mode
-- opt.wildmenu = true -- enable ctrl-n and ctrl-p to scroll thru matches
-- stuff to ignore when tab completing
-- opt.wildignore = '*.o,*.obj,*~,vim/backups,sass-cache,DS_Store,vendor/rails/**,vendor/cache/**,*.gem,log/**,tmp/**,*.png,*.jpg,*.gif'

-- ================ Wrapping and Line Breaks ========================
opt.wrap = false
-- Wrap lines at convenient points
opt.linebreak = true

opt.textwidth = 80

-- ================ Indentation ======================
-- opt.smarttab = true
-- opt.smartindent = true
-- opt.autoindent = true
-- opt.tabstop = 4
-- opt.softtabstop = 4
-- opt.shiftwidth = 4

-- automatically indent braces
opt.cindent = true

-- ================ Folds ============================
-- NOTE: see ufo binds in lua/plugins/ui/ufo.lua

-- fold based on indent
opt.foldmethod = 'indent'
-- deepest fold is 3 levels
opt.foldnestmax = 3

-- ================ Scrolling ========================
-- Minimal number of screen lines to keep above and below the cursor.
opt.sidescrolloff = 15
opt.sidescroll = 1

-- ================ Search and Replace ========================
-- searches incrementally as you type instead of after 'enter'
opt.incsearch = true

-- ================ Movement ========================
-- allow backspace in insert mode
opt.backspace = 'indent,eol,start'

-- ========= Cursor =========
opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,n-v-i:blinkon0'

-- ========= Redirect Temp Files =========
-- backup
opt.backupdir = '$HOME/.vim/backup//,/tmp//,.'
opt.writebackup = false
-- swap
opt.directory = '$HOME/.vim/swap//,/tmp//,.'

-- ================ Persistent Undo ==================
-- Keep undo history across sessions, by storing in file.
-- See also lua/plugins/editing/atone.lua
if fn.has('persistent_undo') == 1 then
  local undo_dir = fn.expand('~/.vim/backups')

  -- Create the directory if it doesn't exist;
  if fn.isdirectory(undo_dir) == 0 then
    fn.mkdir(undo_dir, 'p')
  end

  opt.undodir = undo_dir
end

if vim.g.neovide then
  -- When using rounded borders lualine/tabs clip
  vim.g.neovide_padding_top = 4
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 2
  vim.g.neovide_padding_left = 7
end
