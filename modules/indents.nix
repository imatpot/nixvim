{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkSimple config true "indents" {
  plugins.intellitab.enable = true;
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = indentmini;
      config = lib.utils.viml.fromLua ''
        require("indentmini").setup({
          char = "▏",
        })
      '';
    }
  ];
}
