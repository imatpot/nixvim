{
  config,
  lib,
  ...
}: {
  options = {modules.mini.enable = lib.utils.mkDefaultEnableOption true "mini suite";};

  config = lib.mkIf config.modules.mini.enable {
    modules.icons.enable = lib.mkForce true;

    plugins.mini = {
      enable = true;

      modules = {
        pairs.enabled = true;
        comment.enabled = true;
        align.enabled = true;
        move.enabled = true;
        trailspace.enabled = true;

        surround = {
          denabled = true;
          silent = true;
        };
      };
    };
  };
}
