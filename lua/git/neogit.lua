return {
  {
    'neogit',
    event = 'DeferredUIEnter',
    -- stylua: ignore
    keys = {
      { "<leader>gG", "<cmd>Neogit<CR>", mode = { "n" }, desc = "Toggle neogit" },
    },
    after = function(plugin)
      require('neogit').setup({})
    end,
  },
}
