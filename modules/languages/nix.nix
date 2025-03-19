{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.languages.nix = {
      enable = lib.utils.mkDefaultEnableOption config.modules.languages.all.enable "Nix";

      lsp.enable = lib.utils.mkDefaultEnableOption config.modules.languages.nix.enable "Nix language server";
      formatter.enable = lib.utils.mkDefaultEnableOption config.modules.languages.nix.enable "Nix formatter";
    };
  };

  config = {
    plugins.lsp.servers = lib.mkIf (config.modules.languages.nix.lsp.enable) {
      nil_ls.enable = true;
    };

    plugins.conform-nvim = lib.mkIf (config.modules.languages.nix.formatter.enable) {
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
