{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage config "lua" {
  lsp = {
    plugins.lsp.servers.lua_ls = {
      enable = true;
      settings.diagnostics.globals = [
        "vim"
      ];
    };
  };

  formatter = {
    plugins.conform-nvim.settings = {
      formatters_by_ft.lua = ["stylua"];
      formatters.stylua = {
        command = lib.getExe pkgs.stylua;
        args = ["--indent-type" "Spaces" "--indent-width" "2" "-"];
      };
    };
  };
}
