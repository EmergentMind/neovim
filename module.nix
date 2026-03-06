inputs:
{
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
      ./plugin
    ];
  };
in
{
  imports = [ wlib.wrapperModules.neovim ];

  options.settings.dev_mode = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  # Have neovim use immutable config from /nix/store
  options.settings.wrapped_config = lib.mkOption {
    type = lib.types.either wlib.types.stringable lib.types.luaInline;
    default = "${configSource}";
  };

  # Have neovim use raw config folder for faster prototyping
  options.settings.unwrapped_config = lib.mkOption {
    type = lib.types.either wlib.types.stringable lib.types.luaInline;
    default = lib.generators.mkLuaInline "vim.uv.os_homedir() .. '/dev/nix/neovim'";
  };

  config.settings.config_directory =
    if config.settings.dev_mode then
      config.settings.unwrapped_config
    else
      config.settings.wrapped_config;

  config.settings.aliases = [
    "vi"
    "vim"
  ];

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
      inherit (pkgs)
        universal-ctags
        ripgrep
        fd
        tree-sitter
        ;
    };
  };

  # # use host theme from nix-config
  # config.specs.base16 = {
  #   data = pkgs.vimPlugins.mini-base16;
  #   before = ["INIT_MAIN"];
  #   # get colors from system and pass it
  #   palette = pkgs.lib.filterAttrs (
  #           k: v: builtins.match "base0[0-9A-F]" k != null
  #   ) config.lib.stylix.colors.withHashtag;
  #   config = /* lua */ ''
  #     local info, pname, lazy = ...
  #     require("mini.base16").setup({
  #       palette = palette
  #     })
  #     '';
  # };

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
        marksman # md
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

  config.specs.completion = {
    after = [ "core" ];
    lazy = true;
    data = lib.attrValues {
      inherit (pkgs.vimPlugins)
        blink-cmp
        blink-cmp-avante # TODO: setup
        blink-cmp-conventional-commits
        # blink-cmp-npm #TODO: setup maybe
        luasnip

        colorful-menu-nvim # provide additional info for completion suggestions
        ;
    };
  };

  config.specs.debug = {
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

  config.specs.editing = {
    after = [ "core" ];
    lazy = true;
    data =
      lib.attrValues {
        inherit (pkgs.vimPlugins)
          cutlass-nvim # sends deleted chars to blackhole register
          mini-nvim # QoL tools (pairs, surround, etc)
          nvim-ufo
          todo-comments-nvim
          vim-repeat # better . repetition
          ;
        inherit (config.nvim-lib.neovimPlugins)
          nvim-atone
          nvim-better-n
          nvim-toggler
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
      ];
  };

  # format and lint pkgs both handled here
  config.specs.format = {
    after = [ "core" ];
    lazy = true;
    data = lib.attrValues {
      inherit (pkgs.vimPlugins)
        conform-nvim
        kdl-vim
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
        ruff # python
        yamlfmt
        prettier
        ;
    };
  };

  config.specs.git = {
    after = [ "core" ];
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
    after = [ "core" ];
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
    after = [ "core" ];
    lazy = true;
    data = lib.attrValues {
      inherit (pkgs.vimPlugins)
        fidget-nvim
        hardtime-nvim
        lualine-nvim
        mini-base16
        neo-tree-nvim
        noice-nvim
        nvim-highlight-colors
        nvim-notify
        range-highlight-nvim # Highlight range as specified in commandline e.g. :10,15
        smart-splits-nvim
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
    after = [
      "ui"
      "completion"
    ];
    lazy = true;
    data = lib.attrValues {
      inherit (pkgs.vimPlugins)
        vimwiki
        ;
    };
  };

  config.specMods =
    {
      parentSpec ? null,
      parentOpts ? null,
      parentName ? null,
      config,
      ...
    }:
    {
      # add an extraPackages field to the specs themselves
      options.extraPackages = lib.mkOption {
        type = lib.types.listOf wlib.types.stringable;
        default = [ ];
        description = "An extraPackages spec field to put packages to suffix to the PATH";
      };
    };
  config.extraPackages = config.specCollect (acc: v: acc ++ (v.extraPackages or [ ])) [ ];

  options.settings.neovide = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
  # Build a neovide wrapper
  config.hosts.neovide.nvim-host.enable = config.settings.neovide;

  # Inform lua which top level specs are enabled
  options.settings.cats = lib.mkOption {
    readOnly = true;
    type = lib.types.attrsOf lib.types.bool;
    default = lib.mapAttrs (_: v: v.enable) config.specs;
  };

  options.nvim-lib.neovimPlugins = lib.mkOption {
    readOnly = true;
    type = lib.types.attrsOf wlib.types.stringable;
    # Makes plugins autobuilt from our inputs available with
    # `config.nvim-lib.neovimPlugins.<name_without_prefix>`
    default = config.nvim-lib.pluginsFromPrefix "plugins-" inputs;
  };

  # This is from the official template and allows you to build plugins
  # that aren't in nixpkgs yet.
  options.nvim-lib.pluginsFromPrefix = lib.mkOption {
    type = lib.types.raw;
    readOnly = true;
    default =
      prefix: inputs:
      lib.pipe inputs [
        builtins.attrNames
        (builtins.filter (s: lib.hasPrefix prefix s))
        (map (
          input:
          let
            name = lib.removePrefix prefix input;
          in
          {
            inherit name;
            value = config.nvim-lib.mkPlugin name inputs.${input};
          }
        ))
        builtins.listToAttrs
      ];
  };
}
