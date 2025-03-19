{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    modules.languages.rust = {
      enable = lib.utils.mkDefaultEnableOption config.modules.languages.all.enable "Rust";

      lsp.enable = lib.utils.mkDefaultEnableOption config.modules.languages.rust.enable "Rust language server";
      formatter.enable = lib.utils.mkDefaultEnableOption config.modules.languages.rust.enable "Rust formatter";
    };
  };

  config = {
    plugins.rustaceanvim = lib.mkIf (config.modules.languages.rust.lsp.enable) {
      enable = true;
    };

    plugins.conform-nvim = lib.mkIf (config.modules.languages.rust.formatter.enable) {
      settings = {
        formatters_by_ft.rust = ["rustfmt"];
        formatters.rustfmt.command = lib.getExe pkgs.rustfmt;
      };
    };
  };
}
