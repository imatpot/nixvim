{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.lsp.nix.enable = lib.utils.mkDefaultEnableOption config.modules.lsp.all.enable "nix language server";
    modules.formatter.nix.enable = lib.utils.mkDefaultEnableOption config.modules.formatter.all.enable "nix formatter";
  };

  config = {
    plugins.lsp.servers = lib.mkIf (config.modules.lsp.nix.enable) {
      nil_ls.enable = true;
    };

    plugins.conform-nvim = lib.mkIf (config.modules.formatter.nix.enable) {
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
