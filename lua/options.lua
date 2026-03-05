--
-- ================ Options ========================
--
local opt = vim.opt
local fn = vim.fn

vim.loader.enable() -- bytecode caching

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- ================ General Appearance ========================
opt.hidden = true
-- show line numbers
opt.number = true
opt.termguicolors = true
opt.signcolumn = 'yes'
-- show relative linenumbers
opt.relativenumber = false
-- display status line always
opt.laststatus = 0
-- Store lots of :cmdline
opt.history = 1000
-- Show current mode down the bottom
opt.showmode = true
-- Reload files changed outside vim
opt.autoread = true
-- Redraw only when needed
opt.lazyredraw = true
-- Highlight matching braces
opt.showmatch = true
-- Show current line and column
opt.ruler = false
-- No sounds
opt.visualbell = true
-- Display tabs and trailing spaces visually
opt.list = true
opt.listchars = {
  --tab = '» ',
  trail = '·',
  --nbsp = '␣'
}

-- ========= Clipboard ==========
-- Sync yank with system clipboard
opt.clipboard = "unnamedplus"

-- ================ Basic Completion =======================
opt.wildmode = "list:longest,list:full" -- for tab completion in : command mode
opt.wildmenu = true                     -- enable ctrl-n and ctrl-p to scroll thru matches
-- stuff to ignore when tab completing
opt.wildignore =
"*.o,*.obj,*~,vim/backups,sass-cache,DS_Store,vendor/rails/**,vendor/cache/**,*.gem,log/**,tmp/**,*.png,*.jpg,*.gif";

-- ================ Wrapping and Line Breaks ========================
opt.wrap = false
-- Wrap lines at convenient points
opt.linebreak = true
opt.textwidth = 80
-- Toggle wrap function
-- function ToggleWrap()
--   opt.wrap = not opt.wrap:get()
-- end

-- ================ Indentation ======================
opt.autoindent = true
-- automatically indent braces
opt.cindent = true
opt.smartindent = true
opt.smarttab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.expandtab = true

-- ================ Folds ============================
-- FIXME: This folds section could be replaced with custom functions at some
-- point. See ./plugins/syntax . also some of this might be handled by ufo
-- fold based on indent
opt.foldmethod = "indent"
-- deepest fold is 3 levels
opt.foldnestmax = 3
-- don't fold by default
opt.foldenable = false

-- ================ Splits ============================
opt.splitbelow = true;
opt.splitright = true;

-- ================ Scrolling ========================
-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 5
opt.sidescrolloff = 15
opt.sidescroll = 1

-- ================ Search and Replace ========================
-- Preview incremental substitutions in a split
opt.inccommand = 'split'
-- searches incrementally as you type instead of after 'enter'
opt.incsearch = true
-- highlight search results
opt.hlsearch = true
-- search case insensitive
opt.ignorecase = true
-- search matters if capital letter
opt.smartcase = true


-- ================ Movement ========================
-- allow backspace in insert mode
opt.backspace = "indent,eol,start"

-- ========= Cursor =========
opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,n-v-i:blinkon0";

-- ========= Redirect Temp Files =========
-- backup
opt.backupdir = "$HOME/.vim/backup//,/tmp//,."
opt.writebackup = false
-- swap
opt.directory = "$HOME/.vim/swap//,/tmp//,."

-- FIXME: Better spot for this?
-- ================ Persistent Undo ==================
-- Keep undo history across sessions, by storing in file.
-- Only works all the time.
-- FIXME: enable persistent_undo
if fn.has('persistent_undo') == 1 then
  local undo_dir = fn.expand('~/.vim/backups')

  -- Create the directory if it doesn't exist;
  if fn.isdirectory(undo_dir) == 0 then
    fn.mkdir(undo_dir, 'p')
  end

  opt.undodir = undo_dir
  opt.undofile = true
end
