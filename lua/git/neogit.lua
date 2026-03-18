return {
  {
    'neogit',
    event = 'DeferredUIEnter',
    -- stylua: ignore
    keys = {
      { "<leader>gg", "<cmd>Neogit<CR>", mode = { "n" }, desc = "Toggle neogit" },
    },
    after = function(plugin)
      require('neogit').setup({})
    end,
  },
}
