-- FIXME: not showing up in whichkey
return {
  {
    "nvim-ufo",
    auto_enable = true,
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        mode = "n",
        desc = "Open all folds",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        mode = "n",
        desc = "Close all folds",
      },
      {
        "zr",
        function()
          require("ufo").openFoldsExceptKinds()
        end,
        mode = "n",
        desc = "Open folds except kinds",
      },
      {
        "zm",
        function()
          require("ufo").closeFoldsWith()
        end,
        mode = "n",
        desc = "Close folds with",
      },
      {
        "zK",
        function()
          local winid = require("ufo").peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
        desc = "Peek fold or hover",
      },
    },
    after = function(name)
      -- UFO needs these options
      -- vim.o.foldcolumn = '1'
      -- ensure folds are open to begin with
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })
    end,
  },
}
