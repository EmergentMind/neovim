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

local nv = { "n", "v" }
local nvi = { "n", "v", "i" }

--
-- [[ quality of life ]]
--

-- note: devmode only. requires config files outside the nix store
vim.keymap.set("n", "<leader><leader>e", "<cmd>e ~/src/nix/neovim/<cr>", { desc = "edit neovim flake" })
vim.keymap.set("n", "<leader><leader>r", vim.cmd.reloadconfig, {noremap = true, silent = true})

-- sudo save
vim.keymap.set(
    'c',
    'w!!',
    '<cmd>w !sudo tee > /dev/null %<cr>',
    { desc = 'performs `sudo save` on privileged files' }
  )
-- typo tolerant command abbreviations for :w and friends
vim.keymap.set("ca", "w", "w")
-- also see ./../lua/ui/confirm-quit.lua:13
if not vim.g.neovide then
  vim.keymap.set("ca", "wq", "wq")
  vim.keymap.set("ca", "wq", "wq")
  vim.keymap.set("ca", "q", "q")
end

-- better indenting (stay in visual mode)
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

--
-- [[ movment ]]
--
-- movement
vim.keymap.set("n", "j", "gj", { desc = "move down through wrapped lines" })
vim.keymap.set("n", "k", "gk", { desc = "move up through wrapped lines" })
vim.keymap.set("n", "<c-j>", "<c-d>", { desc = "add bind for 1/2 page down" })
vim.keymap.set("n", "<c-k>", "<c-u>", { desc = "add bind for 1/2 page up" })

-- move lines
vim.keymap.set("n", "<leader>k", "<cmd>m .-2<cr>==", { desc = "move line up" })
vim.keymap.set("n", "<leader>j", "<cmd>m .+1<cr>==", { desc = "move line down" })
vim.keymap.set("v", "k", ":m '<-2<cr>gv=gv", { desc = "move line up" })
vim.keymap.set("v", "j", ":m '>+1<cr>gv=gv", { desc = "move line down" })

vim.keymap.set("n", "<c-d>", "<c-d>zz", { desc = 'scroll down' })
vim.keymap.set("n", "<c-u>", "<c-u>zz", { desc = 'scroll up' })
-- jump to the next search result, center it, and unfold (if relevant)
-- warning: these break better-n
-- vim.keymap.set("n", "n", "nzzzv", { desc = 'next search result' })
-- vim.keymap.set("n", "n", "nzzzv", { desc = 'previous search result' })


-- warning: this breaks registers
-- vim.keymap.set("n", "qq", vim.cmd.quitall, {noremap = true, silent = true})

-- k/j move to wrapped part of next row of a long line if wrapped on screen
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


--
-- [[ Search and replace ]]
--
-- substitute current word
vim.keymap.set("n", "<leader>sr", ":%s/<c-r><c-w>//g<left><left>", { desc = "substitute the word you are currently on" })
-- clear search highlighting
vim.keymap.set("n", "<space><space>", "<cmd>nohlsearch<cr>", { desc = "clear search highlighting" })

-- FIXME: Probably get rid of this
-- select all
vim.keymap.set("i", "<c-a>", "<cmd> norm! ggvg<cr>", { desc = "select all lines in buffer" })


--
-- [[ diagnostics ]]
--
-- also see ./../lua/ui/trouble.lua

vim.keymap.set('n', '[d', function() vim.diagnostic.jump({count=-1, float=true}) end, { desc = 'go to previous diagnostic message' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({count=1, float=true}) end,  { desc = 'go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float,                           { desc = 'open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,                           { desc = 'open diagnostics list' })

--
-- [[ copy / paste ]]
--
vim.keymap.set({ "n", "v" }, '<c-a>', 'gg0vg$', { noremap = true, silent = true, desc = 'select all' })

vim.keymap.set("n", "<leader>yfp", function() vim.fn.setreg("+", vim.fn.expand("%:p")) end,
  { desc = "copy full file path" })
vim.keymap.set("n", "<leader>yrp", function() vim.fn.setreg("+", vim.fn.expand("%")) end,
  { desc = "copy relative file path" })
vim.keymap.set('i', '<c-v>', '<c-r><c-p>+',
  { noremap = true, silent = true, desc = 'paste from clipboard from within insert mode' })
vim.keymap.set("x", "<leader>p", '"_dp',
  { noremap = true, silent = true, desc = '[p]aste over selection without erasing unnamed register' })

--
-- [[ lsp ]]
--
-- also see ./../lua/lsp/init.lua
local l = "<leader>l"
vim.keymap.set("n", l .. "x", vim.cmd.lspstop,  { desc = 'turn of lsp' })
vim.keymap.set("n", l .. "o", vim.cmd.lspstart, { desc = 'turn on lsp' })

--
-- [[ window/split motions ]]
--
-- see ./../lua/ui/smart-splits.lua
-- also see ./30_terminal.lua for split creation

--
-- [[ buffer motions ]]
--
-- l = "<a-b>"
l = "<leader>b"
vim.keymap.set(nv, l .. "h", vim.cmd.bprev,   { desc = 'previous buffer' })
vim.keymap.set(nv, l .. "l", vim.cmd.bnext,   { desc = 'next buffer' })
vim.keymap.set(nv, l .. ".", "<cmd>b#<cr>",   { desc = 'most recent buffer' })
vim.keymap.set(nv, l .. "s", vim.cmd.ls,      { desc = 'list buffers' })
vim.keymap.set(nv, l .. "x", vim.cmd.bdelete, { desc = 'delete buffer' })

--
-- [[ tab motions ]]
--
local function rename_tab()
    vim.ui.input({ prompt = 'new tab name: ' }, function (input)
    if input or input == '' then
      vim.cmd("tabby rename_tab " .. input)
    end
  end)
end

local function create_named_tab()
  vim.cmd.tabnew()
  rename_tab()
end

l = "<a-t>"
vim.keymap.set(nvi, l .. "e",  vim.cmd.tablast,      { silent = true, desc = 'go to last tab' })
vim.keymap.set(nvi, l .. "0",  vim.cmd.tabfirst,     { silent = true, desc = 'go to first tab' })
vim.keymap.set(nvi, l .. "h",  "gt",                 { silent = true, desc = 'go to previous tab' })
vim.keymap.set(nvi, l .. "l",  "gt",                 { silent = true, desc = 'go to next tab' })
vim.keymap.set(nvi, l .. ".",  "g<tab>",             { silent = true, desc = 'go to last accessed tab page' })
vim.keymap.set(nvi, l .. "x",  vim.cmd.tabclose,     { silent = true, desc = 'close current tab' })

local function tab_move(direction)
  -- if we are on the left or right edge, allow wrapping
  local index = vim.api.nvim_tabpage_get_number(0)
  if direction == "left" then
    if index == 1 then
      -- wrap to the end
      vim.cmd("$tabmove")
    else
      vim.cmd("-tabmove")
    end
  elseif direction == "right" then
    local pages = vim.api.nvim_list_tabpages()
    if index == #pages then
      -- wrap to the start
      vim.cmd("0tabmove")
    else
      vim.cmd("+tabmove")
    end
  else
    vim.notify("tab_move: bad direction")
  end
end

local tab_navigation = require('better-n').create({ next = function() tab_move("right") end, prev = function() tab_move("left") end })
vim.keymap.set(nvi, l .. "h",  tab_navigation.prev_key, { desc = 'move tab to left' })
vim.keymap.set(nvi, l .. "l",  tab_navigation.next_key, { desc = 'move tab to right' })

vim.keymap.set(nvi, l .. "n",  vim.cmd.tabnew,       { silent = true, desc = 'create unnamed tab' })
vim.keymap.set(nvi, l .. "n",  create_named_tab,     { silent = true, desc = 'create named tab' })
vim.keymap.set(nvi, l .. 'r',  rename_tab,           { silent = true, desc = 'rename tab' })

local function smart_open(direction)
  local cmd = (direction == 'h' or direction == 'l') and 'vnew' or 'new'
  local modifier = ''

  if direction == 'h' then modifier = 'topleft '
  elseif direction == 'l' then modifier = 'botright '
  elseif direction == 'k' then modifier = 'topleft '
  elseif direction == 'j' then modifier = 'botright '
  end

  vim.cmd(modifier .. cmd)
end

vim.keymap.set('n', '<a-n>h', function() smart_open('h') end, { desc = "split left" })
vim.keymap.set('n', '<a-n>l', function() smart_open('l') end, { desc = "split right" })
vim.keymap.set('n', '<a-n>k', function() smart_open('k') end, { desc = "split up" })
vim.keymap.set('n', '<a-n>j', function() smart_open('j') end, { desc = "split down" })

--
-- [[ scrolling ]]
--

local function scroll(cmd)
  local current_so = vim.opt.scrolloff:get()
  vim.opt.scrolloff = 0
  vim.cmd('normal! ' .. cmd)
  vim.opt.scrolloff = current_so
end

-- put line to actual top/bottom (ignores scrolloff)
vim.keymap.set('n', 'zt', function()
  scroll('zt')
end, { desc = "force zt ignoring scrolloff" })
vim.keymap.set('n', 'zb', function()
  scroll('zb')
end, { desc = "force zt ignoring scrolloff" })

-- remap marks since m is used elsewhere
vim.keymap.set('n', '<leader>m', 'm', {noremap=true, silent=true, desc = "marks: set [a-z] (built-in)"})

--
-- [[ notifications ]]
--

local function dismiss_all()
  require("noice").cmd("dismiss")
  require("notify").dismiss({ silent = true })
  vim.cmd("noh")
end

vim.keymap.set("n", "<esc>", dismiss_all, { desc = "dismiss all notifications and clear hlsearch" })
-- blink uses <c-e> to close pop-up so same idea
vim.keymap.set({ "v", "n", "t", "c"}, "<a-e>", dismiss_all, { desc = "dismiss all notifications and clear hlsearch" })

vim.keymap.set("n", "<leader>ts", function() vim.opt.spell = not vim.opt.spell:get() end, { desc = "toggle spell checking" })
-- fixme: add toggle for numbers

vim.keymap.set('n', "<leader><leader>t", vim.cmd.inspecttree, { desc = "treesitter inspection" })

--
-- [[ experimental ]]
--
-- stuff i'm trying, but don't know if i'll keep
vim.keymap.set('i', 'jk', '<esc>:w<cr>', {noremap=true, silent=true})

-- fix most recent spelling mistake. operations
-- 1. set undo breakpoint
-- 2. switch to normal mode and auto-select first spell suggestion
-- 3. return to after last text changed
-- 4. set undo breakpoint
-- from: https://github.com/theopn/dotfiles/blob/c96a769b/vim/.vimrc
vim.keymap.set({"i", "n", "o"}, "<c-s>", "<c-g>u<esc>[s1z=`]a<c-g>u", { desc = "auto-spell correct"})

-- NOTE: ta these were enabled in my config before and I'm not sure if they were actually doing anything noticeable so disabling for now and will reenable later
-- sort of related to the map above
-- -- undo and redo
-- -- these create undo breakpoints when typing punctuation in insert mode
-- vim.keymap.set('i', ',', ',<c-g>u', { desc = 'update undo when , operator is used in insert mode' })
-- vim.keymap.set('i', '.', '.<c-g>u', { desc = 'update undo when . operator is used in insert mode' })
-- vim.keymap.set('i', '!', '!<c-g>u', { desc = 'update undo when ! operator is used in insert mode' })
-- vim.keymap.set('i', '?', '?<c-g>u', { desc = 'update undo when ? operator is used in insert mode' })
--

-- stylua: ignore end
