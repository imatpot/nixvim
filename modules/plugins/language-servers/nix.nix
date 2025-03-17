{
  config,
  lib,
  ...
}: {
  options = {
    modules.plugins.lsp.nix.enable = lib.mkEnableOption "nix lsp server";
  };

  config = lib.mkIf (config.modules.plugins.lsp.nix.enable || config.modules.plugins.lsp.all.enable) {
    plugins.lsp.servers = lib.utils.enable ["nil_ls"];
  };
}
