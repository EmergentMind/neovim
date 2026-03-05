-- NOTE: Plugin-specific keymaps are located in the plugin file
--
-- ========== Modes Legend ==========
--
--    "n" Normal mode
--    "i" Insert mode
--    "v" Visual and Select mode
--    "s" Select mode
--    "t" Terminal mode
--    ""  Normal, visual, select and operator-pending mode
--    "x" Visual mode only, without select
--    "o" Operator-pending mode
--    "!" Insert and command-line mode
--    "l" Insert, command-line and lang-arg mode
--    "c" Command-line mode

local map = vim.keymap.set

-- ========== Nixvim Config Shortcuts ==========
map('n',
  '<Leader>ve',
  '<cmd>e ~/src/nix/nix-config/home/common/core/nixvim/default.nix<CR>',
  { desc = 'Edit nix-config/home/common/core/nixvim/default.nix' }
)

-- FIXME: does this work with wrapper? This is disabled because for some unknown reason nixvim doesn't symlink to .vimrc
-- map('n', '<Leader>vr', '<cmd>so $MYVIMRC<CR>', { desc = 'Reload vimrc' })

-- Movement
map('n', 'j', 'gj', { desc = 'Move down through wrapped lines' })
map('n', 'k', 'gk', { desc = 'Move up through wrapped lines' })
map('n', '<C-j>', '<C-d>', { desc = 'Add bind for 1/2 page down' })
map('n', '<C-k>', '<C-u>', { desc = 'Add bind for 1/2 page up' })

-- map('n', 'E', '$', { desc = 'Add bind for move to end of line' })
-- disable default move to beginning/end of line
-- map('n', '$', '<nop>')

-- Move Lines
map('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move line up' })
map('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move line down' })
map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move line up' })
map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move line down' })

-- Buffer navigation
map('n', '<Leader>-', ':b#<CR>', { desc = 'Switch to the previous buffer' })

-- Window navigation
map('n', '<Leader>h', '<C-W>h', { desc = 'Move the cursor one window left' })
map('n', '<Leader>j', '<C-W>j', { desc = 'Move the cursor window down' })
map('n', '<Leader>k', '<C-W>k', { desc = 'Move the cursor window up' })
map('n', '<Leader>l', '<C-W>l', { desc = 'Move the cursor window right' })

-- Window management
map('n', '<leader>wd', '<C-W>c', { silent = true, desc = 'Delete window' })
map('n', '<leader>wj', '<C-W>s', { silent = true, desc = 'Split window below' })
map('n', '<leader>wl', '<C-W>v', { silent = true, desc = 'Split window right' })

-- Clear Search Highlighting
map('n', '<space><space>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlighting' })

-- Select all
map('i', '<C-a>', '<cmd> norm! ggVG<cr>', { desc = 'Select all lines in buffer' })

-- Substitute current word
map('n', '<Leader>sr', ':%s/<C-r><C-w>//g<Left><Left>', { desc = 'Substitute the word you are currently on' })

-- sudo Save
map('c', 'w!!', '<cmd>w !sudo tee > /dev/null %<CR>', { desc = 'Performs `sudo save` on privileged files' })

-- Undo and Redo
-- These create undo breakpoints when typing punctuation in insert mode
map('i', ',', ',<C-g>U', { desc = 'Update undo when , operator is used in Insert mode' })
map('i', '.', '.<C-g>U', { desc = 'Update undo when . operator is used in Insert mode' })
map('i', '!', '!<C-g>U', { desc = 'Update undo when ! operator is used in Insert mode' })
map('i', '?', '?<C-g>U', { desc = 'Update undo when ? operator is used in Insert mode' })

-- Better Indenting (stay in visual mode)
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Toggle wrap
map('n', '<leader>wu', ':lua ToggleWrap()<cr>', { silent = true, desc = 'Toggle Line Wrap' })

-- -- Better Pasting
-- -- Paste over without yanking deleted text
map('x', 'p', '"_dP', { desc = 'Deletes to void register and paste over' })
-- -- Delete that voids register
map({ 'n', 'v' }, '<leader>D', '"_d', { desc = 'Delete to void register' })
