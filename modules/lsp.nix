{
  config,
  lib,
  ...
}: {
  options = {
    modules.plugins.lsp.enable = lib.mkEnableOption "lsp plugin";
    modules.plugins.lsp.all.enable = lib.mkEnableOption "all configured lsp servers";
  };

  config = lib.mkIf config.modules.plugins.lsp.enable {
    plugins.lsp = {
      enable = true;
      inlayHints = true;
    };
  };
}
