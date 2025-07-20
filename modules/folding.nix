{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule' config true "ufo" {
  plugins.nvim-ufo = {
    enable = true;
    lazyLoad.settings.event = ["BufNewFile" "BufRead"];
  };

  opts = {
    foldlevel = 99;
    foldlevelstart = 99;
  };
}
