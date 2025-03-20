{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage config "nix" {
  plugins = {
    lsp.servers = lib.mkIf (config.modules.languages.nix.lsp.enable) {
      nil_ls.enable = true;
    };

    conform-nvim = lib.mkIf (config.modules.languages.nix.formatter.enable) {
      settings = {
        formatters_by_ft.nix = ["alejandra"];

        formatters.alejandra = {
          command = lib.getExe pkgs.alejandra;
          args = ["--quiet" "-"];
        };
      };
    };

    hmts.enable = true;
  };
}
