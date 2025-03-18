{
  config,
  lib,
  ...
}: {
  options = {
    modules.formatter.enable = lib.utils.mkDefaultEnableOption true "formatter";
    modules.formatter.all.enable = lib.utils.mkDefaultEnableOption true "all configured formatters";
  };

  config = lib.mkIf config.modules.formatter.enable {
    plugins.conform-nvim.enable = true;

    keymaps = let
      runFormatter = "lua require('conform').format()";
    in [
      {
        key = "<leader>f";
        action = "<CMD>${runFormatter}<CR>";
        options.desc = "Format current file";
      }
      {
        key = "<leader>F";
        action = "<CMD>${runFormatter}<CR><CMD>w<CR>";
        options.desc = "Format and save current file";
      }
    ];
  };
}
