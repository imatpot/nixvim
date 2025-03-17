{
  config,
  lib,
  ...
}: {
  options = {modules.icons.enable = lib.mkEnableOption "icons";};

  config = lib.mkIf config.modules.icons.enable {
    plugins.web-devicons.enable = true;
  };
}
