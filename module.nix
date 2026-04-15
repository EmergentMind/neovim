inputs:
{
  config,
  wlib,
  lib,
  pkgs,
  ...
}:
let
  # This duplicates introdus, so could just use a function so the files/folders
  # don't need to keep synced
  configSource = lib.fileset.toSource {
    root = ./.;
    fileset =
      map (p: lib.optional (builtins.pathExists p) p) [
        ./init.lua
        ./lua
        ./after
        ./plugin
        ./snippets
      ]
      |> lib.flatten
      |> lib.fileset.unions;
  };
in
{
  imports = [
    inputs.introdus.wrapperModules.neovim
  ];
  # Extend the introdus neovim template with any additional functionality we want
  config = {
    settings = {
      # Introdus is the base config we build on
      baseConfig = "${inputs.introdus}/wrappers/neovim";

      # When not in dev-mode, the neovim-wrapper's /nix/store folder is our
      # config extending introdus
      wrappedConfig = "${configSource}";
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
          # inherit (pkgs.vimPlugins)
          #   ;
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
              mini-base16
              nvim-highlight-colors # highlight color code with its color
              vim-illuminate # Highlight similar words as are under the cursor
              nvim-numbertoggle # Use relative number on focused buffer only
              ;
            inherit (config.nvim-lib.neovimPlugins)
              modes # modes specific cursor and line highlighting
              ;
          }
          ++ lib.optionals config.settings.devMode (
            lib.attrValues {
              inherit (config.nvim-lib.neovimPlugins)
                screenkey # adding this under devmode because I don't think we want it otherwise
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
