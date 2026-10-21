{
  description = "Personal IDE setup powered by NixVim";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    flakeUtils.url = "github:numtide/flake-utils";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nypkgs = {
      url = "github:yunfachi/nypkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    prettypst = {
      url = "github:antonwetzel/prettypst";
      flake = false;
    };
  };

  outputs = inputs @ {
    nixpkgs,
    flakeUtils,
    nixvim,
    ...
  }:
    flakeUtils.lib.eachDefaultSystem (system: let
      lib'' = nixpkgs.lib;
      lib' = lib''.extend nixvim.lib.overlay;
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

        # FIXME: update-nix-fetchgit is unmaintained and doesn't support pipe operators, so using ./**/*.nix is no longer possible.
        updater = pkgs.writeShellScriptBin "nixvim-flake-updater" ''
          ${lib''.getExe pkgs.update-nix-fetchgit} --verbose ./overlays/vim-plugins.nix 2>&1 | grep --line-buffered -i "updating"
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
