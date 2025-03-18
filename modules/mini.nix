{
  config,
  lib,
  ...
}: {
  options = {modules.mini.enable = lib.mkEnableOption "mini suite";};

  config = lib.mkIf config.modules.mini.enable {
    modules.icons.enable = true;

    plugins.mini = {
      enable = true;

      modules = {
        pairs = {};
        comment = {};
        align = {};
        surround = {};
        move = {};
        trailspace = {};
        tabline = {};
      };
    };
  };
}
