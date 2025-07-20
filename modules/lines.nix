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
      lazyLoad.settings.event = ["BufNewFile" "BufRead"];

      settings = {
        char = "╎";
        virtcolumn = "81,101,121";
      };
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    {
      # TODO: lazy load on event = BufNewFile, BufRead
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
