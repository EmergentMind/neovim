-- FIXME: break into separate modules
return {
  { import = "plugins.editing.auto-session" },
  {
    "mini.nvim",
    auto_enable = true,
    event = "DeferredUIEnter",
    after = function(name)
      --FIXME: Pick a few of these to start and then TODO the rest for
      --future self
      require("mini.comment").setup()
      require("mini.ai").setup()
      require("mini.bracketed").setup()
      require("mini.pairs").setup()
      -- require("mini.surround").setup({})
    end
  },
  {
    "undotree",
    auto_enable = true,
    cmd = {
      "UndotreeToggle",
      "UndotreeHide",
      "UndotreeShow",
      "UndotreeFocus",
    },
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" },
    },
    after = function(name)
      -- Configuration before loading
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SplitWidth = 40
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },
  {
    "vim-sleuth",
    auto_enable = true,
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "todo-comments.nvim",
    auto_enable = true,
    event = { "BufReadPost", "BufNewFile" },
    after = function(name)
      require("todo-comments").setup({
        signs = true, -- show icons in sign column
        keywords = {
          FIX = {
            icon = " ",
            color = "error",
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
          },
          TODO = { icon = "", color = "info" },
          HACK = { icon = "", color = "warning" },
          WARN = { icon = "", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = "⚡", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = "", color = "hint", alt = { "INFO" } },
          TEST = { icon = "", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        -- patterns from: https://github.com/folke/todo-comments.nvim/issues/10
        search = {
          pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]]
        },
        highlight = {
          pattern = [[.*<((KEYWORDS)%(\(.{-1,}\))?):]]
        },
      })
    end,
  }
}
