{
  config,
  lib,
  ...
}: {
  options = {
    modules.formatter.enable = lib.mkEnableOption "formatter";
    modules.formatter.all.enable = lib.mkEnableOption "all configured formatters";
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
        action = "<CMD>${runFormatter} | w<CR>";
        options.desc = "Format and save current file";
      }
    ];
  };
}
