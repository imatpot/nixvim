{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.lsp.nix.enable = lib.mkEnableOption "nix lsp server";
    modules.formatter.nix.enable = lib.mkEnableOption "nix formatter";
  };

  config = {
    plugins.lsp.servers =
      lib.mkIf (config.modules.lsp.nix.enable || config.modules.lsp.all.enable)
      (lib.utils.enable ["nil_ls"]);

    plugins.conform-nvim =
      lib.mkIf (config.modules.formatter.nix.enable || config.modules.formatter.all.enable)
      {
        settings = {
          formatters_by_ft.nix = {
            __unkeyed-1 = "alejandra";
          };

          formatters.alejandra = {
            command = lib.getExe pkgs.alejandra;
            args = ["--quiet" "-"];
          };
        };
      };
  };
}
