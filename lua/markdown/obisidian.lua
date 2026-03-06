return {
  {
    "obsidian.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("obsidian").setup({
        legacy_commands = false,
        disable_metadata = true,
        -- FIXME: set this up properly
        workspaces = {
          {
            name = "personal",
            path = "~/sync/obsidian-vault-01/",
          },
        },
      })
      vim.keymap.set(
        "n",
        "<leader>ot",
        require("obsidian").util.toggle_checkbox(),
        { desc = "[O]bsidian [T]oggle checkbox" }
      )
    end,
  },
}
