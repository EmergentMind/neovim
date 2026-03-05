return {
  {
    "nvim-lint",
    auto_enable = true,
    for_cat = 'lint',
    event = "FileType",
    after = function(plugin)
      require('lint').linters_by_ft = {
        bash = { 'shellcheck' },
        c = { 'clang-tidy' },
        javascript = { 'prettier', 'eslint' },
        markdown = {'markdownlint', 'vale',},
        nix = nixInfo(nil, "settings", "cats", "nix") and { "nixd" } or nil,
        -- rust = { 'clippy' },
        typescript = { 'prettier', 'eslint' },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
