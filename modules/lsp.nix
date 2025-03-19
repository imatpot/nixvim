{
  config,
  lib,
  ...
}: {
  options = {
    modules.lsp.enable = lib.utils.mkDefaultEnableOption true "lsp plugin";
  };

  config = lib.mkIf config.modules.lsp.enable {
    plugins.lsp = {
      enable = true;
      inlayHints = true;
    };
  };
}
