{
  config,
  lib,
  ...
}:
lib.utils.modules.mkLanguage' config "colors" {
  plugins.ccc = {
    enable = true;
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<leader>Ch" "<CMD>CccHighlighterToggle<CR>" "Toggle colors highlights")
    (mkKeymap' "<leader>Cc" "<CMD>CccConvert<CR>" "Convert color")
    (mkKeymap' "<leader>C/" "<CMD>CccPick<CR>" "Pick color")
  ];
}
