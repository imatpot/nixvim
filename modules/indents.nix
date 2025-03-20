{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkSimple config "indents" true {
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
