{
  config,
  lib,
  ...
}: {
  options = {
    modules.indent-lines.enable = lib.utils.mkDefaultEnableOption true "indent lines";
  };

  config = lib.mkIf config.modules.indent-lines.enable {
    plugins.indent-blankline = {
      enable = true;
      settings.indent.char = "▏";
    };
  };
}
