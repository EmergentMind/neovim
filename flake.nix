{
  description = "EmergentMind's Standalone Neovim Config";

  outputs = {
    self,
    nixpkgs,
    wrappers,
    ...
  } @ inputs:
  let
    systems = [
      "x86_64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    module = nixpkgs.lib.modules.importApply ./module.nix inputs;
    wrapper = wrappers.lib.evalModule module;
  in {
    wrapperModules = {
      default = module;
      neovim = self.wrapperModules.default;
    };
    wrappers = {
      default = wrapper.config;
      neovim = self.wrappers.default;
    };
    packages = forAllSystems (
      system:
      let
        pkgs = import nixpkgs {inherit system;};
      in {
        default = wrapper.config.wrap {inherit pkgs;};
        neovim = self.packages.${system}.default;
      }
    );
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  # undo tree for neovim
  inputs.plugins-atone = {
    url = "github:XXiaoA/atone.nvim";
    flake = false;
  };
}
