-- TODO: investigate other mini tools
return {
  {
    "mini.nvim",
    auto_enable = true,
    event = "DeferredUIEnter",
    after = function(name)
      require("mini.ai").setup()
      require("mini.comment").setup()
      --NOTE: this supersedes the normal `s` key, use `r` instead
      require("mini.surround").setup({
        add = "sa",
        delete = "sd",
        find = "sf",
        find_left = "sF",
        highlight = "sh",
        replace = "sr",
        suffix_last = "sl",
        suffix_next = "sn",
      })
    end,
  },
}
