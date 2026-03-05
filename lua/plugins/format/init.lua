return {
     {
        "conform.nvim",
		    auto_enable = true,
        for_cat = 'format',
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
                    lua = nixInfo(nil, "settings", "cats", "lua") and { "stylua" } or nil,
                    nix = nixInfo(nil, "settings", "cats", "nix") and { "nixfmt" } or nil,
                    python = { "ruff" },
                    -- rust = { "rustfmt" },
                    sh = { "shfmt", "shellharden" },
                    toml = { 'taplo' },
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
    -- FIXME: Not needed anymore because of conform format on save?
    -- Setup format on save
   --  vim.api.nvim_create_autocmd("LspAttach", {
   --    callback = function(args)
   --      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
   --      if client:supports_method('textDocument/formatting') then
   --        vim.api.nvim_create_autocmd("BufWritePre", {
   --          buffer = args.buf,
   --          callback = function()
   --            -- Allow per-project shut off via vim.o.exrc files
   --            -- FIXME: Add a function to write such a file to the root of a project
   --            if vim.b.disable_autoformat then
   --              return
   --            end
   --
   --            vim.lsp.buf.format({
   --              async = false,
   --              bufnr = args.buf,
   --              id = client.id
   --            })
   --          end,
   --        })
   --      end
   --    end,
   -- })
}
