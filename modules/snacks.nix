{
  config,
  lib,
  ...
}: {
  options = {
    modules.snacks.enable = lib.mkEnableOption "snacks suite";
  };

  config = lib.mkIf config.modules.snacks.enable {
    plugins.snacks = {
      enable = true;

      settings = {
        bigfile.enabled = true;
        scroll.enabled = true;
        quickfile.enabled = true;
        words.enabled = true;
      };
    };
  };
}
