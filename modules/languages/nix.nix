{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage config "nix" {
  lsp = {
    plugins = {
      hmts.enable = true;

      lsp.servers.nixd = {
        enable = true;
        settings = let
          flakeExpr =
            # nix
            ''(builtins.getFlake "${inputs.self}")'';
          systemExpr =
            # nix
            ''''${builtins.currentSystem}'';
        in {
          formatting.command = ["nix fmt"];

          nixpkgs.expr =
            # nix
            "import ${flakeExpr}.inputs.nixpkgs { system = ${systemExpr}; }";

          options = {
            nixvim.expr =
              # nix
              "${flakeExpr}.packages.${systemExpr}.nvim.options";

            # TODO: make nixvim not rely on dotfiles for these options

            nixos.expr =
              # nix
              "${flakeExpr}.inputs.dotfiles.nixosConfigurations.shinobi.options";

            home-manager.expr =
              # nix
              "${flakeExpr}.inputs.dotfiles.homeConfigurations.mladen.options";

            nix-darwin.expr =
              # nix
              "${flakeExpr}.inputs.dotfiles.darwinConfigurations.mcdonalds.options";
          };
        };
      };
    };
  };

  linter = {
    plugins.lint.lintersByFt.nix = ["statix" "deadnix"];
  };

  formatter = {
    plugins.conform-nvim.settings = {
      formatters_by_ft.nix = ["alejandra"];

      formatters.alejandra = {
        command = lib.getExe pkgs.alejandra;
        args = ["--quiet" "-"];
      };
    };
  };
}
