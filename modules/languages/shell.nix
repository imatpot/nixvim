{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage' config "shell" {
  plugins = {
    lsp.servers.bashls.enable = true;

    lint = {
      linters.shellcheck.cmd = lib.getExe pkgs.shellcheck;
      lintersByFt.bash = ["shellcheck"];
    };

    conform-nvim.settings = {
      formatters_by_ft.bash = ["shfmt"];
      formatters.shfmt.command = lib.getExe pkgs.shfmt;
    };
  };
}
