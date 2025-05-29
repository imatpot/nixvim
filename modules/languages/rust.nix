{
  pkgs,
  config,
  lib,
  ...
}:
lib.utils.modules.mkLanguage' config "rust" {
  plugins = {
    # TODO: configure components (analyzer, clippy, etc.) or use manual config
    rustaceanvim.enable = true;

    conform-nvim.settings = {
      formatters_by_ft.rust = ["rustfmt"];
      formatters.rustfmt.command = lib.getExe pkgs.rustfmt;
    };
  };
}
