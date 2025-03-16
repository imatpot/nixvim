{
  config,
  lib,
  utils,
  ...
}: {
  options = {
    modules.lsp.nix.enable = lib.mkEnableOption "nix lsp server";
  };

  config = lib.mkIf (config.modules.lsp.nix.enable || config.modules.lsp.all.enable) {
    plugins.lsp.servers = utils.enable ["nil_ls"];
  };
}
