{
  description = "EmergentMind's Standalone Neovim Config";

  outputs = {
    self,
    nixpkgs,
    wrappers,
    flake-parts,
    ...
  } @ inputs:
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
    # FIXME: wire this up
    # potentially better undo tree for neovim
    plugins-atone = {
      url = "github:XXiaoA/atone.nvim";
      flake = false;
    };
  };
}
