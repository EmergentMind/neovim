inputs:
{
  config,
  wlib,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.introdus.wrapperModules.neovim
  ];
  # Extend the introdus neovim template with any additional functionality we want
  config = {
    settings = {
      extraConfig = "${inputs.introdus}/wrappers/neovim";
      unwrappedConfig = lib.generators.mkLuaInline "vim.uv.os_homedir() .. '/src/nix/neovim'";
    };

    nvim-lib.pluginInputs = [
      inputs
      inputs.introdus
    ];

    # NOTE: Specs are enabled by default
    specs = {
      # Extending existing spec from introdus
      lsp = {
        data = lib.attrValues {
          inherit (pkgs.vimPlugins)
            scope-nvim # Per tabpage-scoped buffers
            mini-base16
            nvim-highlight-colors # highlight color code with its color
            range-highlight-nvim # Highlight range as specified in commandline e.g. :10,15
            vim-illuminate # Highlight similar words as are under the cursor
            nvim-numbertoggle # Use relative number on focused buffer only
            vimade # Dim unfocused buffers
            ;
        };
        extraPackages = lib.optionals config.settings.devMode (
          lib.attrValues {
            inherit (pkgs)
              postgres-language-server
              ts_query_ls
              typescript-language-server
              ;
            # oh python, you silly bastard
            inherit (pkgs.python313Packages)
              python-lsp-server
              ;
          }
        );
      };
      ui = {
        data =
          lib.attrValues {
            inherit (pkgs.vimPlugins)
              scope-nvim # Per tabpage-scoped buffers
              ;
          }
          ++ lib.optionals config.settings.devMode (
            lib.attrValues {
              inherit (config.nvim-lib.neovimPlugins)
                #FIXME:
                # lua-console
                ;
            }
          )
          ++ lib.optionals config.settings.terminalMode (
            lib.attrValues {
              inherit (pkgs.vimPlugins)
                toggleterm-nvim
                ;
            }
          );
      };
      ai = {
        after = [
          "ui"
          "completion"
        ];
        lazy = true;
        data = lib.attrValues {
          inherit (pkgs.vimPlugins)
            avante-nvim

            # These are already in config.specs.completions:
            # blink-cmp-avante
            ;
        };
      };
      completion = {
        after = [ "core" ];
        lazy = true;
        data = lib.attrValues {
          inherit (pkgs.vimPlugins)
            blink-cmp-avante # TODO: setup
            # blink-cmp-npm #TODO: setup maybe
            ;
        };
      };
      debug = {
        after = [ "core" ];
        lazy = true;
        data = lib.attrValues {
          inherit (pkgs.vimPlugins)
            nvim-dap
            nvim-dap-ui
            nvim-dap-virtual-text
            nvim-dap-python
            nvim-dap-lldb
            ;
        };
      };
      editing = {
        after = [ "core" ];
        lazy = true;
        data =
          lib.attrValues {
            inherit (pkgs.vimPlugins)
              mini-comment
              nvim-ufo
              vim-repeat # better . repetition
              ;
            inherit (config.nvim-lib.neovimPlugins)
              nvim-atone
              ;
          }
          ++ [
            (pkgs.vimPlugins.nvim-treesitter.withPlugins (
              plugins: with plugins; [
                typescript
              ]
            ))
          ];
      };
      git = {
        after = [ "core" ];
        lazy = true;
        data = lib.attrValues {
          inherit (pkgs.vimPlugins)
            vim-fugitive
            ;
        };
      };

    };
  };
}
