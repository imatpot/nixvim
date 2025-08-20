{
  description = "Personal IDE setup powered by NixVim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgsMaster.url = "github:nixos/nixpkgs/master";
    flakeUtils.url = "github:numtide/flake-utils";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nypkgs = {
      url = "github:yunfachi/nypkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/4.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # dotfiles = {
    #   url = "github:imatpot/dotfiles";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs @ {
    nixpkgs,
    flakeUtils,
    nixvim,
    ...
  }:
    flakeUtils.lib.eachDefaultSystem (system: let
      lib'' = nixpkgs.lib;
      lib' = lib''.extend inputs.nixvim.lib.overlay;
      pkgs = import nixpkgs {
        inherit system;
        config = {allowUnfree = true;};
        overlays = map (overlay: import overlay {inherit inputs system;}) (utils.umport {path = ./overlays;});
      };
      utils = import ./utils {
        inherit inputs system pkgs;
        lib = lib';
      };
      lib = lib'.extend (self: super: {inherit utils;});
      nixvimLib = nixvim.lib.${system};
      nixvim' = nixvim.legacyPackages.${system};
      config = {
        inherit pkgs;

        module = {
          imports = utils.umport {
            paths = [
              ./modules
              ./config
            ];
          };
        };

        extraSpecialArgs = {
          inherit inputs lib;
        };
      };
      nvim = nixvim'.makeNixvimWithModule config;
    in {
      packages = {
        inherit nvim;
        default = nvim;

        updater = pkgs.writeShellScriptBin "nixvim-flake-updater" ''
          ${lib''.getExe pkgs.update-nix-fetchgit} --verbose ./**/*.nix 2>&1 | grep --line-buffered -i "updating"
          nix flake update
        '';
      };

      overlays.default = final: prev: {
        neovim = nvim;
      };

      checks.default = nixvimLib.check.mkTestDerivationFromNvim {
        inherit nvim;
        name = "mkTestDerivationFromNvim";
      };

      formatter = pkgs.writeShellScriptBin "alejandra" ''
        exec ${pkgs.alejandra}/bin/alejandra --quiet "$@"
      '';

      inherit lib; # this is nice for debugging in the repl
    });
}
