# https://github.com/BirdeeHub/nix-wrapper-modules/blob/main/templates/neovim/README.md
{
  description = "EmergentMind's Neovim Config";

  outputs =
    {
      self,
      nixpkgs,
      wrappers,
      flake-parts,
      introdus,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ wrappers.flakeModules.wrappers ];
      systems = nixpkgs.lib.platforms.all;

      perSystem =
        { pkgs, config, ... }:
        {
          packages = {
            full = config.packages.neovim.wrap {
              settings = {
                devMode = true;
                neovide = true;
                terminalMode = true;
                unwrappedConfig = "/home/ta/src/nix/neovim";
                baseConfig = lib.mkForce "/home/ta/src/nix/introdus/ta/wrappers/neovim";
              };
            };
          };
        };

      flake.wrappers = {
        neovim = lib.modules.importApply ./module.nix (inputs // introdus.inputs);
        default = self.wrapperModules.neovim;
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    # Shared wrapper modules and configs
    introdus = {
      # url = "git+ssh://git@codeberg.org/fidgetingbits/introdus?ref=ta";
      url = "path:///home/ta/src/nix/introdus/ta";
    };

    ###
    # Neovim plugins from outside nixpkgs, either for fetching latest source or
    # because there is no package yet. See nvim-lib.neovimPlugins in module.nix
    ###
    #FIXME: move these to introdus
    plugins-modes = {
      url = "github:mvllow/modes.nvim";
      flake = false;
    };
    plugins-screenkey = {
      url = "github:NStefan002/screenkey.nvim";
      flake = false;
    };
    plugins-nvim-atone = {
      url = "github:XXiaoA/atone.nvim";
      flake = false;
    };
    plugins-telescope-toggleterm = {
      url = "github:da-moon/telescope-toggleterm.nvim";
      flake = false;
    };
  };
}
