return {
  {
    "vim-fugitive",
    cmd = { "G", "Git", "Gdiffsplit", "Gvdiffsplit", "Gedit", "Gread", "Gwrite",
      "Ggrep", "GMove", "Glgrep", "GRename", "GDelete", "GRemove", "GBrowse",
      "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles",
      "DiffviewRefresh", "DiffviewFileHistory", },
    keys = {
      { "<leader>gs", "<cmd>G<CR>", mode = { "n" }, desc = "Quick git status" },
      { "<leader>gj", "<cmd>diffget //3<CR>", mode = { "n" }, desc = "Quick git merge: take from right page (tab 3) upstream" },
      { "<leader>gf", "<cmd>diffget //2<CR>", mode = { "n" }, desc = "Quick git merge: take from left page (tab 2) head" },
    },
    -- after = function(plugin)
    --   require("fugitive").setup({})
    -- end
  },
}
