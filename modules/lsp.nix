{
  config,
  lib,
  ...
}: {
  options = {
    modules.lsp.enable = lib.mkEnableOption "lsp plugin";
    modules.lsp.all.enable = lib.mkEnableOption "all configured lsp servers";
  };

  config = lib.mkIf config.modules.lsp.enable {
    plugins.lsp = {
      enable = true;
      inlayHints = true;
    };
  };
}
