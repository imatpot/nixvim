{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkModule config true "indents" {
  plugins.intellitab.enable = true;
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = indentmini;
      config =
        lib.utils.viml.fromLua
        # lua
        ''
          require("indentmini").setup({
            char = "▏",
          })
        '';
    }
  ];
}
