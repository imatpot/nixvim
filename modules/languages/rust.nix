{
  pkgs,
  config,
  lib,
  ...
}:
lib.utils.modules.mkLanguage config "rust" {
  lsp = {
    # TODO: configure components (analyzer, clippy, etc.) or use manual config
    plugins.rustaceanvim.enable = true;
  };

  formatter = {
    plugins.conform-nvim.settings = {
      formatters_by_ft.rust = ["rustfmt"];
      formatters.rustfmt.command = lib.getExe pkgs.rustfmt;
    };
  };
}
