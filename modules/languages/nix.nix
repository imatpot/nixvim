{
  config,
  lib,
  ...
}: {
  options = {
    modules.plugins.lsp.nix.enable = lib.mkEnableOption "nix lsp server";
  };

  config = {
    plugins.lsp.servers = lib.mkIf (config.modules.plugins.lsp.nix.enable || config.modules.plugins.lsp.all.enable) (lib.utils.enable ["nil_ls"]);
  };
}
