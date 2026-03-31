return {
  {
    'gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    after = function(name)
      require('gitsigns').setup({
        signs = {
          add = { text = '+' },
          change = { text = '+' },
          delete = { text = '-' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
          untracked = { text = '?' },
        },
        -- signs_staged = {
        --   add = { text = '+' },
        --   change = { text = '+' },
        --   delete = { text = '-' },
        --   topdelete = { text = '‾' },
        --   changedelete = { text = '~' },
        --   untracked = { text = '?' },
        -- },
        -- signs_staged_enable = true,
        -- signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        -- numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        -- linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        -- word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        -- watch_gitdir = {
        -- follow_files = true,
        -- },
        -- auto_attach = true,
        -- attach_to_untracked = true,
        -- current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        -- current_line_blame_opts = {
        --   virt_text = true,
        --   virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        --   delay = 1000,
        --   ignore_whitespace = false,
        --   virt_text_priority = 100,
        --   use_focus = true,
        -- },
        -- current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        -- sign_priority = 6,
        -- update_debounce = 100,
        -- status_formatter = nil, -- Use default
        -- max_file_length = 40000, -- Disable if file is longer than this (in lines)
        -- preview_config = {
        --   -- Options passed to nvim_open_win
        --   border = 'single',
        --   style = 'minimal',
        --   relative = 'cursor',
        --   row = 0,
        --   col = 1,
        --
        -- },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']c', bang = true })
            else
              gs.nav_hunk('next')
            end
          end, { desc = 'Next git hunk' })

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[c', bang = true })
            else
              gs.nav_hunk('prev')
            end
          end, { desc = 'Previous git hunk' })

          -- Actions
          -- FIXME: revisit these after deciding to keep fugitive or neogit
          -- map('n', '<leader>gs', gs.stage_hunk, { desc = 'Stage hunk' })
          -- map('n', '<leader>gr', gs.reset_hunk, { desc = 'Reset hunk' })
          -- map('v', '<leader>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Stage hunk' })
          -- map('v', '<leader>gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Reset hunk' })
          -- map('n', '<leader>gS', gs.stage_buffer, { desc = 'Stage buffer' })
          -- map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
          -- map('n', '<leader>gR', gs.reset_buffer, { desc = 'Reset buffer' })
          -- map('n', '<leader>gp', gs.preview_hunk, { desc = 'Preview hunk' })
          -- map('n', '<leader>gb', function() gs.blame_line{full=true} end, { desc = 'Blame line' })
          -- map('n', '<leader>gd', gs.diffthis, { desc = 'Diff this' })
          -- map('n', '<leader>gD', function() gs.diffthis('~') end, { desc = 'Diff this ~' })

          -- Toggles
          map('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = 'Toggle git blame line' })
          map('n', '<leader>gtd', gs.toggle_deleted, { desc = 'Toggle git show deleted' })

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select git hunk' })
        end,
      })
    end,
  },
}
