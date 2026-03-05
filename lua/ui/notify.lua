return {
  {
    "nvim-notify",
    priority = 1000,
    after = function(plugin)
      local notify = require("notify")
      notify.setup({
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { focusable = false })
        end,
        -- Avoid warning when using transparency
        background_colour = "#212F3D",
      })
      vim.notify = notify
      vim.keymap.set("n", "<Esc>", function()
        notify.dismiss({ silent = true })
      end, { desc = "Dismiss notify popup and clear hlsearch" })
    end,
  },
}
