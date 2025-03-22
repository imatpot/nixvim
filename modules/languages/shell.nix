{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage config "shell" {
  plugins = {
    lsp.servers = lib.mkIf (config.modules.languages.shell.lsp.enable) {
      bashls.enable = true;
    };

    lint.lintersByFt = lib.mkIf (config.modules.languages.nix.linter.enable) {
      nix = ["shellcheck"];
    };

    conform-nvim = lib.mkIf (config.modules.languages.shell.formatter.enable) {
      settings = {
        formatters_by_ft.bash = ["shfmt"];
        formatters.shfmt.command = lib.getExe pkgs.shfmt;
      };
    };
  };
}
