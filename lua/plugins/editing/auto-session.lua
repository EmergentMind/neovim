return {
  {
    "auto-session",
    after = function(plugin)
      require("auto-session").setup({
        enabled = true,
        auto_save = true,
        auto_restore = false,
        --include git branch name in session name to differentiate btwn sessions for different branches
        use_git_branch = true,
        log_level = "error",
        suppress_dirs = {
          "~/",
            "~/downloads",
            "~/doc",
            "~/tmp"
        },
      })
    end,
  },
}
