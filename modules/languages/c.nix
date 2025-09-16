{
  config,
  lib,
  ...
}:
lib.utils.modules.mkLanguage' config "c" {
  plugins = {
    lsp.servers.clangd.enable = true;
    conform-nvim.settings.formatters_by_ft.c = ["clang-format"];
  };
}
