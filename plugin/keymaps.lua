-- stylua: ignore start
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

-- typo tolerance for :W and friends
vim.cmd([[command! W w]])
vim.cmd([[command! Wq wq]])
vim.cmd([[command! WQ wq]])
vim.cmd([[command! Q q]])
-- sudo Save
map("c", "w!!", "<cmd>w !sudo tee > /dev/null %<CR>", { desc = "Performs `sudo save` on privileged files" })

-- Config Shortcuts
map("n", "<Leader>ve", "<cmd>e ~/src/nix/neovim/<CR>", { desc = "Edit neovim flake" })
-- FIXME: setup hot reloads with wrapper-modules
-- map('n', '<Leader>vr', '<cmd>so $MYVIMRC<CR>', { desc = 'Reload vimrc' })

-- Movement
map("n", "j", "gj", { desc = "Move down through wrapped lines" })
map("n", "k", "gk", { desc = "Move up through wrapped lines" })
map("n", "<C-j>", "<C-d>", { desc = "Add bind for 1/2 page down" })
map("n", "<C-k>", "<C-u>", { desc = "Add bind for 1/2 page up" })

-- map('n', 'E', '$', { desc = 'Add bind for move to end of line' })
-- disable default move to beginning/end of line
-- map('n', '$', '<nop>')

-- Move Lines
map("n", "<leader>K", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("n", "<leader>J", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("v", "<leader>K", ":m '<-2<cr>gv=gv", { desc = "Move line up" })
map("v", "<leader>J", ":m '>+1<cr>gv=gv", { desc = "Move line down" })

-- Window/split motions
-- See smart-splits.nvim maps instead

-- Buffer motions
l = "<leader>b"
map("n", "<leader>-", "<cmd>b#<CR>", { desc = 'Most recent buffer' })
map("n", l .. "h", "<cmd>bprev<CR>", { desc = 'Previous buffer' })
map("n", l .. "l", "<cmd>bnext<CR>", { desc = 'Next buffer' })
map("n", l .. "s", "<cmd>ls<CR>", { desc = 'List buffers' })
map("n", l .. "x", "<cmd>bdelete<CR>", { desc = 'Delete buffer' })

-- Tab motions
l = "<leader><tab>"
map("n", l .. "e", ":tablast", { noremap = true, silent = true, desc = 'Go to last tab' })
map("n", l .. "0", ":tabfirst", { noremap = true, silent = true, desc = 'Go to first tab' })
map("n", l .. "h", "gT", { noremap = true, silent = true, desc = 'Go to previous tab' })
map("n", l .. "l", "gt", { noremap = true, silent = true, desc = 'Go to next tab' })
map("n", l .. ".", "g<tab>", { noremap = true, silent = true, desc = 'Go to last accessed tab page' })
map("n", l .. "<tab>", ":tabnew<CR>", { noremap = true, silent = true, desc = 'Open new tab' })
map("n", l .. "x", ":tabclose", { noremap = true, silent = true, desc = 'Close current tab' })
map("n", l .. "H", ":-tabmove", { noremap = true, silent = true, desc = 'Move tab to left' })
map("n", l .. "L", ":+tabmove", { noremap = true, silent = true, desc = 'Move tab to right' })

-- Window management
map("n", "<leader>wd", "<C-W>c", { silent = true, desc = "Delete window" })
map("n", "<leader>wj", "<C-W>s", { silent = true, desc = "Split window below" })
map("n", "<leader>wl", "<C-W>v", { silent = true, desc = "Split window right" })

-- Clear Search Highlighting
map("n", "<space><space>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })

-- Select all
map("i", "<C-a>", "<cmd> norm! ggVG<cr>", { desc = "Select all lines in buffer" })

-- Substitute current word
map("n", "<Leader>sr", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "Substitute the word you are currently on" })

-- Undo and Redo
-- These create undo breakpoints when typing punctuation in insert mode
map("i", ",", ",<C-g>U", { desc = "Update undo when , operator is used in Insert mode" })
map("i", ".", ".<C-g>U", { desc = "Update undo when . operator is used in Insert mode" })
map("i", "!", "!<C-g>U", { desc = "Update undo when ! operator is used in Insert mode" })
map("i", "?", "?<C-g>U", { desc = "Update undo when ? operator is used in Insert mode" })

-- Better Indenting (stay in visual mode)
map("v", "<", "<gv")
map("v", ">", ">gv")

--[[
 Experimental keymaps

 Stuff I'm trying, but don't know if I'll keep
]]

-- toggle spellcheck
vim.keymap.set("n", "<leader>ts", function()
  vim.opt.spell = not vim.opt.spell:get()
end, { desc = "Toggle spell checking" })

-- dismiss/clear notifications
vim.keymap.set("n", "<Esc>", function()
  require("noice").cmd("dismiss")
  require("notify").dismiss({ silent = true })
  vim.cmd("noh")
end, { desc = "Dismiss all notifications and clear hlsearch" })

-- stylua: ignore end
