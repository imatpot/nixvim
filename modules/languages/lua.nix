{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.languages.lua = {
      enable = lib.utils.mkDefaultEnableOption config.modules.languages.all.enable "Lua";

      lsp.enable = lib.utils.mkDefaultEnableOption config.modules.languages.lua.enable "Lua language server";
      formatter.enable = lib.utils.mkDefaultEnableOption config.modules.languages.lua.enable "Lua formatter";
    };
  };

  config = {
    plugins = {
      lsp.servers = lib.mkIf (config.modules.languages.lua.lsp.enable) {
        lua_ls.enable = true;
      };

      conform-nvim = lib.mkIf (config.modules.languages.lua.formatter.enable) {
        settings = {
          formatters_by_ft.lua = ["stylua"];
          formatters.stylua.command = lib.getExe pkgs.stylua;
        };
      };

      hmts.enable = true;
    };
  };
}
