{
  config,
  lib,
  ...
}:
lib.utils.modules.mkSimple config true "formatter" {
  plugins.conform-nvim.enable = true;

  keymaps = let
    runFormatter = "lua require('conform').format()";
  in
    with lib.utils.keymaps; [
      (mkKeymap' "<leader>f" "<CMD>${runFormatter}<CR>" "Format current file")
      (mkKeymap' "<leader>F" "<CMD>${runFormatter}<CR><CMD>w<CR>" "Format and save current file")
    ];
}
