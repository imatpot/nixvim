{
  description = "Personal IDE setup powered by NixVim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    utils,
    nixvim,
    ...
  }:
    utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config = {allowUnfree = true;};
      };
      nixvimLib = nixvim.lib.${system};
      nixvim' = nixvim.legacyPackages.${system};
      nixvimConfiguration = {
        inherit pkgs;
        module = import ./configuration.nix;
        extraSpecialArgs = {inherit inputs;};
      };
    in {
      packages.default = nixvim'.makeNixvimWithModule nixvimConfiguration;
      checks.default = nixvimLib.check.mkTestDerivationFromNvim nixvimConfiguration;
      formatter = pkgs.alejandra;
    });
}
