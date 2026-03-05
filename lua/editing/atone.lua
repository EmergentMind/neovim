return {
  "nvim-atone",
  event = "VimEnter",
  after = function(plugin)
    require("atone").setup()
    vim.keymap.set("n", "<leader>u", function()
      vim.cmd("Atone")
    end, { desc = "Open Undo Tree" })
  end,
}
