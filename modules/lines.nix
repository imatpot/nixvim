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
        highlight = "VirtColumn";
      };
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = indentmini;
      config = lib.utils.plugins.setup "indentmini" {
        char = "▏";
      };
    }
  ];
}
