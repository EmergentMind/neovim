return {
  {
    "iamcco/markdown-preview.nvim",
    event = "DeferredUIEnter",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    keys = {
      --FIXME: deprecate 'cp' in favor of 'mp'
      -- { "<leader>cp", "<cmd>MarkdownPreview<cr>", mode = { "n" }, desc = "Markdown Preview" },
      { "<leader>mp", "<cmd>MarkdownPreview<cr>", mode = { "n" }, desc = "Markdown Preview" },
    },
    after = function(plugin)
      require("markdown-preview.nvim").setup({})
    end,
  },
}
