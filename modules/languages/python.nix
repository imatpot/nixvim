{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage config "python" {
  plugins = {
    lsp.servers.ruff.enable = true;

    conform-nvim.settings = {
      formatters_by_ft.python = [
        "ruff_fix"
        "ruff_format"
        "ruff_organize_imports"
      ];

      formatters = {
        ruff_fix.command = lib.getExe pkgs.ruff;
        ruff_format.command = lib.getExe pkgs.ruff;
        ruff_organize_imports.command = lib.getExe pkgs.ruff;
      };
    };

    lint.lintersByFt.python = ["ruff"];

    dap-python.enable = true;
  };
}
