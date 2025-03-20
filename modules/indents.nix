{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.indent-lines.enable = lib.utils.mkDefaultEnableOption true "indent lines";
  };

  config = lib.mkIf config.modules.indent-lines.enable {
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
  };
}
