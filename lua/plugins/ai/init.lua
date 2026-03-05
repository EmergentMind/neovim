return {
  {
    "avante.nvim",
    event = "DeferredUIEnter",
    keys = {
      -- FIXME: add binds if needed
      --{ "<leader>__", "<cmd>foo<CR>", mode = { "n"}, desc = "foo" },
    },
    after = function(name)
      require('avante').setup({
        diff = {
          autojump = true,
          debug = false,
          list_opener = "copen",
        },
        highlights = {
          diff = {
            current = "DiffText",
            incoming = "DiffAdd",
          },
        },
        hints = {
          enabled = true,
        },
        mappings = {
          -- diff = {
          --   both = "cb",
          --   next = "]x",
          --   none = "c0",
          --   ours = "co",
          --   prev = "[x",
          --   theirs = "ct",
          -- },
        },
        auto_suggestions_provider = "ollama",
        provider = "gemini",
        providers = {
          ollama = {
            endpoint = "http://127.0.0.1:11434",
            model = "qwen2.5-coder:32b",
            extra_request_body = {
              temperature = 0,
              max_completion_tokens = 4096,
            },
          },
          gemini = {
            model = "gemini-2.5-pro",
            extra_request_body = {
              max_tokens = 4096,
              temperature = 0,
            },
          },
          claude = {
            endpoint = "https://api.anthropic.com",
            model = "claude-3-5-sonnet-20240620",
            extra_request_body = {
              max_tokens = 4096,
              temperature = 0,
            },
          },
        },
        windows = {
          sidebar_header = {
            align = "center",
            rounded = true,
          },
          width = 30,
          wrap = true,
        },
      })
    end,
  },
}
