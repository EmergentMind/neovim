return {
     {
        "conform.nvim",
        lazy = false,
        keys = {
            { "<leader>FF", desc = "Format File" },
        },
        after = function(plugin)
            local conform = require("conform")

            conform.setup({
                formatters_by_ft = {
                    -- Conform will run multiple formatters sequentially

                    -- go = { "gofmt", "golint" },
                    -- Use a sub-list to run only the first available formatter
                    javascript = { { "prettierd", "prettier" } },
                    json = { 'prettier' },
                    lua = { "stylua" },
                    nix = { "nixfmt" },
                    python = { "ruff" },
                    -- rust = { "rustfmt" },
                    sh = { "shfmt", "shellharden" },
                    toml = { 'taplo' },
                    typescript = { { "prettierd", "prettier" } },
                    yaml = { 'prettier', 'yamlfmt' },
                    zsh = { "shfmt", "shellharden" },
                },
                format_on_save = {
                    -- These options will be passed to conform.format()
                    timeout_ms = 500,
                    lsp_format = "fallback",
                  },
            })

            vim.keymap.set({ "n", "v" }, "<leader>FF", function()
                conform.format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 1000,
                })
            end, { desc = "Format File" })
        end,
    },
}
