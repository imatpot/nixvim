{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.languages.shell = {
      enable = lib.utils.mkDefaultEnableOption config.modules.languages.all.enable "Shell";

      lsp.enable = lib.utils.mkDefaultEnableOption config.modules.languages.shell.enable "Shell language server";
      formatter.enable = lib.utils.mkDefaultEnableOption config.modules.languages.shell.enable "Shell formatter";
    };
  };

  config = {
    plugins = {
      lsp.servers = lib.mkIf (config.modules.languages.shell.lsp.enable) {
        bashls.enable = true;
      };

      conform-nvim = lib.mkIf (config.modules.languages.shell.formatter.enable) {
        settings = {
          formatters_by_ft.bash = ["shfmt"];
          formatters.shfmt.command = lib.getExe pkgs.shfmt;
        };
      };

      hmts.enable = true;
    };
  };
}
