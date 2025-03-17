{
  config,
  lib,
  ...
}: {
  options = {
    modules.lsp.nix.enable = lib.mkEnableOption "nix lsp server";
  };

  config = {
    plugins.lsp.servers = lib.mkIf (config.modules.lsp.nix.enable || config.modules.lsp.all.enable) (lib.utils.enable ["nil_ls"]);
  };
}
