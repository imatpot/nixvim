{
  config,
  lib,
  ...
}: {
  options = {
    modules.snacks.enable = lib.utils.mkDefaultEnableOption true "snacks suite";
  };

  config = lib.mkIf config.modules.snacks.enable {
    plugins.snacks = {
      enable = true;

      settings = {
        bigfile.enabled = true;
        quickfile.enabled = true;
        words.enabled = true;
      };
    };
  };
}
