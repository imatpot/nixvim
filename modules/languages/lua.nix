{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage config "lua" {
  plugins = {
    lsp.servers = lib.mkIf (config.modules.languages.lua.lsp.enable) {
      lua_ls.enable = true;
    };

    lint.lintersByFt = lib.mkIf (config.modules.languages.nix.linter.enable) {
      nix = ["luacheck" "selene"];
    };

    conform-nvim = lib.mkIf (config.modules.languages.lua.formatter.enable) {
      settings = {
        formatters_by_ft.lua = ["stylua"];
        formatters.stylua = {
          command = lib.getExe pkgs.stylua;
          args = ["--indent-type" "Spaces" "--indent-width" "2" "-"];
        };
      };
    };
  };
}
