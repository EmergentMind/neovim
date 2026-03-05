inputs: {
  config,
  wlib,
  lib,
  pkgs,
  ...
}:
let
  configSource = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./init.lua
      ./lua
      ./after
    ];
  };
in
{
  imports = [ wlib.wrapperModules.neovim ];
  config.settings.config_directory = "${configSource}";

  # NOTE: Specs are enabled by default
  config.specs.core = {
    data = lib.attrValues {
      inherit (pkgs.vimPlugins)
      auto-session
      lze
      lzextras
      plenary-nvim # lua function lib used by several other plugins

      nvim-web-devicons
      ;
    };
    extraPackages = lib.attrValues {
      inherit(pkgs)
        universal-ctags
        ripgrep
        fd
        tree-sitter
        ;
    };
  };

  config.specs.lsp = {
    data = lib.attrValues {
      inherit (pkgs.vimPlugins)
      nvim-lspconfig
      lazydev-nvim
      ;
    };
    extraPackages = lib.attrValues {
      inherit (pkgs)
      bash-language-server
      just-lsp
      lua-language-server
      marksman #md
      nixd
      nix-doc
      postgres-language-server
      stylua
      taplo # toml
      ts_query_ls
      typescript-language-server
      ;

      # oh python, you silly bastard
      inherit (pkgs.python313Packages)
      python-lsp-server
      ;
    };
  };

  config.specs.ai = {
    after = ["ui" "completion"];
    lazy = true;
    data = lib.attrValues {
      inherit (pkgs.vimPlugins)
      avante-nvim
      # copilot # FIXME:

      # These are already in config.specs.completions:
      # blink-cmp-avante
    ;
    };
  };

  config.specs.completion = {
    after = ["core"];
    lazy = true;
    data = lib.attrValues {
      inherit (pkgs.vimPlugins)
      blink-cmp
      blink-cmp-avante #TODO: setup
      blink-cmp-conventional-commits
      # blink-cmp-npm #TODO: setup maybe
      blink-compat # allows running cmp-foo through blink-cmp
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      cmp-nvim-lua
      luasnip

      colorful-menu-nvim # provide additional info for completion suggestions

      #FIXME: is this still needed?
      #YouCompleteMe # Code completion engine
      # TODO(vim): is this wiped out by others above
      # supertab # Use <tab> for insert completion needs - https://github.com/ervandew/supertab/
     ;
    };
  };

  config.specs.debug = {
    after = ["core"];
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

  config.specs.editing = {
    after = ["core"];
    lazy = true;
    data = lib.attrValues {
      inherit (pkgs.vimPlugins)
      comment-nvim
      mini-nvim # QoL tools (pairs, surround, etc)
      nvim-ufo
      todo-comments-nvim
      undotree
      vim-repeat # better . repetition
      vim-sleuth # autoadjust swiftwidth and expandtab heuristically
      ;
    }
    ++ [
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (
        plugins: with plugins; [
          # asm
          bash
          c
          # cmake
          # cpp
          kdl
          # go
          git_config
          gitignore
          gitcommit
          html
          # java
          javascript
          # jinja
          jq
          json
          json5
          just
          kconfig
          lua
          markdown
          nasm
          nix
          # plantuml
          python
          regex
          rust
          toml
          typescript
          yaml
          zsh
        ]
     ))
    ] ;
  };

  # format and lint pkgs both handled here
  config.specs.format = {
    after = [ "core" ];
    lazy = true;
    data = lib.attrValues {
      inherit (pkgs.vimPlugins)
        conform-nvim
        ;
    };
    extraPackages = lib.attrValues {
      inherit (pkgs.vimPlugins)
        nvim-lint
       ;
      inherit (pkgs)
        eslint
        kdlfmt
        shfmt
        shellharden
        nixfmt
        rustfmt
        ruff #python
        yamlfmt
        prettier
        ;
    };
  };
  config.specs.git = {
    after = ["core"];
    lazy = true;
    data = lib.attrValues {
      inherit (pkgs.vimPlugins)
      gitsigns-nvim
      neogit
      vim-fugitive
    ;
    };
  };

  config.specs.markdown = {
    after = [ "core" ];
    lazy = true;
    data = lib.attrValues {
      inherit (pkgs.vimPlugins)
        vim-markdown-toc
        markdown-preview-nvim
        obsidian-nvim
        ;
    };
  };

  config.specs.search = {
    after = ["core"];
    lazy = true;
    data = lib.attrValues {
      inherit (pkgs.vimPlugins)
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-ui-select-nvim
      flash-nvim
      ;
    };
  };

  config.specs.ui = {
    after = ["core"];
    lazy = true;
    data = lib.attrValues {
      inherit (pkgs.vimPlugins)
      fidget-nvim
      lualine-nvim
      mini-base16
      neo-tree-nvim
      noice-nvim
      nvim-highlight-colors
      nvim-notify
      range-highlight-nvim # Highlight range as specified in commandline e.g. :10,15
      snacks-nvim
      trouble-nvim
      vim-illuminate # Highlight similar words as are under the cursor
      nvim-numbertoggle # Use relative number on focused buffer only
      vimade # Dim unfocused buffers
      which-key-nvim # keymap helper
      wilder-nvim
      zen-mode-nvim
      ;
    };
  };
  config.specs.wiki = {
    after = ["ui" "completion"];
    lazy = true;
    data = lib.attrValues {
      inherit (pkgs.vimPlugins)
      vimwiki
    ;
    };
  };

  config.specMods = {
    parentSpec ? null,
    parentOpts ? null,
    parentName ? null,
    config,
    ...
  }: {
    # add an extraPackages field to the specs themselves
    options.extraPackages = lib.mkOption {
      type = lib.types.listOf wlib.types.stringable;
      default = [];
      description = "An extraPackages spec field to put packages to suffix to the PATH";
    };
  };
  config.extraPackages = config.specCollect (acc: v: acc ++ (v.extraPackages or [])) [];

  options.settings.neovide = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
  # Build a neovide wrapper
  config.hosts.neovide.nvim-host.enable = config.settings.neovide;

  # Inform our lua of which top level specs are enabled
  options.settings.cats = lib.mkOption {
    readOnly = true;
    type = lib.types.attrsOf lib.types.bool;
    default = builtins.mapAttrs (_: v: v.enable) config.specs;
  };

  options.nvim-lib.neovimPlugins = lib.mkOption {
     readOnly = true;
     type = lib.types.attrsOf wlib.types.stringable;
     # Makes plugins autobuilt from our inputs available with
     # `config.nvim-lib.neovimPlugins.<name_without_prefix>`
     default = config.nvim-lib.pluginsFromPrefix "plugins-" inputs;
  };

  # allows building plugins from inputs set that aren't in nixpkgs
  options.nvim-lib.pluginsFromPrefix = lib.mkOption {
    type = lib.types.raw;
    readOnly = true;
    default = prefix: inputs:
      lib.pipe inputs [
        builtins.attrNames
        (builtins.filter (s: lib.hasPrefix prefix s))
        (map (
          input: let
            name = lib.removePrefix prefix input;
          in {
            inherit name;
            value = config.nvim-lib.mkPlugin name inputs.${input};
          }
        ))
        builtins.listToAttrs
      ];
  };
}
