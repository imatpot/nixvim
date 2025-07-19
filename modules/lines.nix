{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkModule' config true "lines" {
  plugins = {
    intellitab.enable = true;

    virt-column = {
      enable = true;
      settings = {
        char = "╎";
        virtcolumn = "81,101,121";
      };
    };
  };

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
