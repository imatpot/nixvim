{
  config,
  lib,
  ...
}: {
  options = {
    modules.which-key.enable = lib.utils.mkDefaultEnableOption true "which-key";
  };

  config = lib.mkIf config.modules.which-key.enable {
    plugins.which-key = {
      enable = true;
      settings = {
        delay = 500;
        icons.mappings = false;
      };
    };
  };
}
