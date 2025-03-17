{
  description = "Personal IDE setup powered by NixVim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flakeUtils.url = "github:numtide/flake-utils";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nypkgs = {
      url = "github:yunfachi/nypkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    flakeUtils,
    nixvim,
    ...
  }:
    flakeUtils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config = {allowUnfree = true;};
        overlays = [(import ./overlays/vim-plugins.nix)];
      };
      utils = import ./utils {
        inherit inputs system pkgs;
        lib = inputs.nixpkgs.lib;
      };
      nixvimLib = nixvim.lib.${system};
      nixvim' = nixvim.legacyPackages.${system};
      config = {
        inherit pkgs;

        module = {
          imports = utils.umport {paths = [./config ./modules];};
        };

        extraSpecialArgs = let
          lib' = inputs.nixpkgs.lib.extend (self: super: {inherit utils;});
          lib = lib'.extend inputs.nixvim.lib.overlay;
        in {
          inherit inputs lib;
        };
      };
    in {
      packages.default = nixvim'.makeNixvimWithModule config;

      checks.default = nixvimLib.check.mkTestDerivationFromNvim config;

      formatter = pkgs.writeShellScriptBin "alejandra" ''
        exec ${pkgs.alejandra}/bin/alejandra --quiet "$@"
      '';
    });
}
