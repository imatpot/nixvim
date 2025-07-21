{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule' config true "ufo" {
  plugins.nvim-ufo = {
    enable = true;
  };

  opts = {
    foldlevel = 99;
    foldlevelstart = 99;
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "=" "za" "Toggle folding")
    (mkKeymap' "<leader>=" "zi" "Toggle all folds")
  ];
}
