{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage' config "nix" {
  plugins = {
    hmts.enable = true;

    lsp.servers = {
      statix = {
        enable = true;
        packageFallback = true;
      };

      nixd = {
        enable = true;
        packageFallback = true;
        settings = let
          flakeExpr =
            # nix
            ''(builtins.getFlake "${inputs.self}")'';
          systemExpr =
            # nix
            ''''${builtins.currentSystem}'';
          dotfilesExpr =
            # nix
            ''(builtins.getFlake "github:imatpot/dotfiles")'';
        in {
          formatting.command = ["nix fmt"];

          nixpkgs.expr =
            # nix
            "import ${flakeExpr}.inputs.nixpkgs { system = ${systemExpr}; }";

          options = {
            nixvim.expr =
              # nix
              "${flakeExpr}.packages.${systemExpr}.nvim.options";

            nixos.expr =
              # nix
              "${dotfilesExpr}.nixosConfigurations.shinobi.options";

            home-manager.expr =
              # nix
              "${dotfilesExpr}.homeConfigurations.mladen.options";

            nix-darwin.expr =
              # nix
              "${dotfilesExpr}.darwinConfigurations.mcdonalds.options";
          };
        };
      };
    };

    lint = {
      linters.deadnix.cmd = lib.getExe pkgs.deadnix;
      lintersByFt.nix = ["deadnix"];
    };

    conform-nvim.settings = {
      formatters_by_ft.nix = ["alejandra"];

      formatters.alejandra = {
        command = lib.getExe pkgs.alejandra;
        args = ["--quiet" "-"];
      };
    };
  };
}
