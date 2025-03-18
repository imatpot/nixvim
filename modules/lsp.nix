{
  config,
  lib,
  ...
}: {
  options = {
    modules.lsp.enable = lib.utils.mkDefaultEnableOption true "lsp plugin";
    modules.lsp.all.enable = lib.utils.mkDefaultEnableOption true "all configured language servers";
  };

  config = lib.mkIf config.modules.lsp.enable {
    plugins.lsp = {
      enable = true;
      inlayHints = true;
    };
  };
}
