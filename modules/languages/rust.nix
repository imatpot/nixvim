{
  pkgs,
  config,
  lib,
  ...
}:
lib.utils.modules.mkLanguage config "rust" {
  plugins = {
    rustaceanvim = lib.mkIf (config.modules.languages.rust.lsp.enable) {
      # TODO: configure components (analyzer, clippy, etc.)
      enable = true;
    };

    conform-nvim = lib.mkIf (config.modules.languages.rust.formatter.enable) {
      settings = {
        formatters_by_ft.rust = ["rustfmt"];
        formatters.rustfmt.command = lib.getExe pkgs.rustfmt;
      };
    };
  };
}
