{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage config "shell" {
  lsp = {
    plugins.lsp.servers.bashls.enable = true;
  };

  linter = {
    plugins.lint.lintersByFt.bash = ["shellcheck"];
  };

  formatter = {
    plugins.conform-nvim.settings = {
      formatters_by_ft.bash = ["shfmt"];
      formatters.shfmt.command = lib.getExe pkgs.shfmt;
    };
  };
}
