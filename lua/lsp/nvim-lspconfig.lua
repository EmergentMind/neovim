-- NOTE: This config uses lzextras.lsp handler
-- https://github.com/BirdeeHub/lzextras?tab=readme-ov-file#lsp-handler
-- Because we have the paths, we can set a more performant fallback function
-- for when you don't provide a filetype to trigger on yourself.
-- If you do provide a filetype, this will never be called.

nixInfo.lze.h.lsp.set_ft_fallback(function(name)
  local lspcfg = nixInfo.get_nix_plugin_path "nvim-lspconfig"
  if lspcfg then
    local ok, cfg = pcall(dofile, lspcfg .. "/lsp/" .. name .. ".lua")
    return (ok and cfg or {}).filetypes or {}
  else
    -- the less performant thing we are trying to avoid at startup
    return (vim.lsp.config[name] or {}).filetypes or {}
  end
end)

return {
  {
    "nvim-lspconfig",
    auto_enable = true,
    lsp = function(plugin)
      vim.lsp.config(plugin.name, plugin.lsp or {})
      vim.lsp.enable(plugin.name)
    end,
    -- set up our on_attach function once before the spec loads
    before = function(_)
      vim.lsp.config('*', {
        on_attach = function(_, bufnr)
          -- we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local nmap = function(keys, func, desc)
            if desc then
              desc = 'LSP: ' .. desc
            end
            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
          end

          -- diagnostic lspBuffer
          nmap('gd', vim.lsp.buf.definition, 'Goto Definition')
          nmap('gr', function() Snacks.picker.lsp_references() end, 'Goto References')
          nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
          nmap('gI', function() Snacks.picker.lsp_implementations() end, 'Goto Implementation')
          nmap('gT', vim.lsp.buf.type_definition, 'Type Definition')
          -- See `:help K` for why this keymap
          nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
          nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

          nmap('<leader>cr', vim.lsp.buf.rename, 'Code Rename')
          nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
          nmap('<leader>ds', function() Snacks.picker.lsp_symbols() end, 'Document Symbols')

          nmap('<leader>ws', function() Snacks.picker.lsp_workspace_symbols() end, 'Workspace Symbols')
          nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
          nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder')
          nmap('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, 'Workspace List Folders')

          -- diagnostic
          nmap('<leader>cd', vim.diagnostic.open_float, 'Line Diagnostics')
          nmap(']d', vim.diagnostic.goto_next, 'Next Diagnostics')
          nmap(']d', vim.diagnostic.goto_prev, 'Previous Diagnostics')

          -- Create a command `:Format` local to the LSP buffer
          vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            vim.lsp.buf.format()
          end, { desc = 'Format current buffer with LSP' })

          local _border = "rounded"

          vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover, {
              border = _border
            }
          )
          vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
            vim.lsp.handlers.signature_help, {
              border = _border
            }
          )
          vim.diagnostic.config {
            float = { border = _border }
          };
          require('lspconfig.ui.windows').default_options = {
            border = _border
          }
        end
        ,
      })
    end,
  },
}
