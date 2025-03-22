{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage config "nix" {
  lsp = {
    plugins = {
      lsp.servers.nixd.enable = true;
      hmts.enable = true;
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
