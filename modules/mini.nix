{
  config,
  lib,
  ...
}: {
  options = {modules.mini.enable = lib.utils.mkDefaultEnableOption true "mini suite";};

  config = lib.mkIf config.modules.mini.enable {
    modules.icons.enable = true;

    plugins.mini = {
      enable = true;

      modules = {
        pairs.enabled = true;
        comment.enabled = true;
        align.enabled = true;
        surround.enabled = true;
        move.enabled = true;
        trailspace.enabled = true;
      };
    };
  };
}
