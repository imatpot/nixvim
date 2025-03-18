{
  config,
  lib,
  ...
}: {
  options = {
    modules.icons.enable = lib.utils.mkDefaultEnableOption true "icons";
  };

  config = lib.mkIf config.modules.icons.enable {
    plugins.mini = {
      enable = true;
      mockDevIcons = true;
      modules.icons.enabled = true;
    };
  };
}
