-- stylua: ignore start
-- note: plugin-specific keymaps are located in the plugin file
--
-- ========== modes legend ==========
--
--    "n" normal mode
--    "i" insert mode
--    "v" visual and select mode
--    "s" select mode
--    "t" terminal mode
--    ""  normal, visual, select and operator-pending mode
--    "x" visual mode only, without select
--    "o" operator-pending mode
--    "!" insert and command-line mode
--    "l" insert, command-line and lang-arg mode
--    "c" command-line mode

local nv  = { "n", "v" }
local nvi = { "n", "v", "i" }

--
-- [[ Quality of Life ]]
--

-- sudo save
vim.keymap.set( 'c', 'w!!', '<cmd>w !sudo tee > /dev/null %<cr>', { desc = 'performs `sudo save` on privileged files' })

-- better indenting (stay in visual mode)
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

--
-- [[ Search and replace ]]
--
-- substitute current word
vim.keymap.set(
  'n',
  '<leader>sr',
  ':%s/<c-r><c-w>//g<left><left>',
  { desc = 'substitute the word you are currently on' }
)
-- clear search highlighting
vim.keymap.set('n', '<space><space>', '<cmd>nohlsearch<cr>', { desc = 'clear search highlighting' })

--
-- [[ Copy / Paste ]]
--
vim.keymap.set({ "n", "o", }, 'gP', "i<CR><Esc>PkJxJx", { desc = "Paste line without breaks before cursor"} )
vim.keymap.set({ "n", "o", }, 'gp', "a<CR><Esc>PkJxJx", { desc = "Paste line without breaks after cursor"} )

-- NOTE: ta these were enabled in my config before and I'm not sure if they were actually doing anything noticeable so disabling for now and will reenable later
-- sort of related to the map above
-- -- undo and redo
-- -- these create undo breakpoints when typing punctuation in insert mode
-- vim.keymap.set('i', ',', ',<c-g>u', { desc = 'update undo when , operator is used in insert mode' })
-- vim.keymap.set('i', '.', '.<c-g>u', { desc = 'update undo when . operator is used in insert mode' })
-- vim.keymap.set('i', '!', '!<c-g>u', { desc = 'update undo when ! operator is used in insert mode' })
-- vim.keymap.set('i', '?', '?<c-g>u', { desc = 'update undo when ? operator is used in insert mode' })

-- stylua: ignore end
