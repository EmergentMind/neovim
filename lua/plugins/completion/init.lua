return {
  {
    "blink.cmp.avante",
    auto_enable = true,
    dep_of = { "blink.cmp" },
  },
  {
    "blink.cmp.conventional.commits",
    auto_enable = true,
    dep_of = { "blink.cmp" },
  },
  -- FIXME: revisit if these needed or not. Likely no
  -- {
  --   "blink.compat",
  --   auto_enable = true,
  --   dep_of = { "cmp-cmdline" },
  -- },
  -- {
  --   "cmp-cmdline",
  --   auto_enable = true,
  --   on_plugin = { "blink.cmp" },
  --   load = nixInfo.lze.loaders.with_after,
  -- },
  {
    "colorful-menu.nvim",
    auto_enable = true,
    on_plugin = { "blink.cmp" },
  },
  {
    "luasnip",
    auto_enable = true,
    dep_of = { "blink.cmp" },
    after = function(_)
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      local ls = require('luasnip')

      vim.keymap.set({ "i", "s" }, "<M-n>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end)
    end,
  },
  {
    "blink.cmp",
    auto_enable = true,
    event = "DeferredUIEnter",
    after = function(_)
      require("blink.cmp").setup({
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- See :h blink-cmp-config-keymap for configuring keymaps
        keymap = {
          preset = 'default',
        },
        cmdline = {
          enabled = true,
          completion = {
            menu = {
              auto_show = true,
            },
          },
          -- sources = function()
          --   local type = vim.fn.getcmdtype()
          --   -- Search forward and backward
          --   if type == '/' or type == '?' then return { 'buffer' } end
          --   -- Commands
          --   if type == ':' or type == '@' then return { 'cmdline', 'cmp_cmdline' } end
          --   return {}
          -- end,
        },
        fuzzy = {
          sorts = {
            'exact',
            -- defaults
            'score',
            'sort_text',
          },
        },
        signature = {
          enabled = true,
          window = {
            show_documentation = true,
          },
        },
        completion = {
          menu = {
            draw = {
              treesitter = { 'lsp' },
              components = {
                label = {
                  text = function(ctx)
                    return require("colorful-menu").blink_components_text(ctx)
                  end,
                  -- highlight = function(ctx)
                  --   return require("colorful-menu").blink_components_highlight(ctx)
                  -- end,
                  text = function(ctx)
                  -- default kind icon
                  local icon = ctx.kind_icon
                  -- if LSP source, check for color derived from documentation
                  if ctx.item.source_name == "LSP" then
                  local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr ~= "" then
                  icon = color_item.abbr
                  end
                  end
                  return icon .. ctx.icon_gap
                  end,
                  highlight = function(ctx)
                  -- default highlight group
                  local highlight = "BlinkCmpKind" .. ctx.kind
                  -- if LSP source, check for color derived from documentation
                  if ctx.item.source_name == "LSP" then
                  local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr_hl_group then
                  highlight = color_item.abbr_hl_group
                  end
                  end
                  return highlight
                  end,
                },
              },
            },
          },
          documentation = {
            auto_show = true,
          },
        },
        sources = {
          default = { 'lsp', 'path', 'buffer', 'omni' },
          providers = {
            path = {
              score_offset = 50,
            },
            lsp = {
              score_offset = 40,
            },
            cmp_cmdline = {
              name = 'cmp_cmdline',
              module = 'blink.compat.source',
              score_offset = -100,
              opts = {
                cmp_name = 'cmdline',
              },
            },
          },
        },
      })
    end,
  },
}
