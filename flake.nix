{
  description = "EmergentMind's Standalone Neovim Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ###
    # Neovim plugins from outside nixpkgs, either for fetching latest source or
    # because there is no package yet. See nvim-lib.neovimPlugins in module.nix
    ###
    plugins-nvim-atone = {
      url = "github:XXiaoA/atone.nvim";
      flake = false;
    };
    plugins-nvim-better-n = {
      url = "github:jonatan-branting/nvim-better-n";
      flake = false;
    };
    plugins-nvim-toggler = {
      url = "github:nguyenvukhang/nvim-toggler";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      wrappers,
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ wrappers.flakeModules.wrappers ];
      systems = nixpkgs.lib.platforms.all;

      perSystem =
        { pkgs, ... }:
        {
          # wrappers.pkgs = pkgs; # choose a different `pkgs`
          wrappers.control_type = "exclude"; # | "build"  (default: "exclude")
          wrappers.packages = { };
        };
      flake.wrappers.default = nixpkgs.lib.modules.importApply ./module.nix inputs;
    };
}
