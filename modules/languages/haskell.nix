{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage' config "haskell" {
  plugins = {
    lsp.servers.hls = {
      enable = true;
      installGhc = true;
      packageFallback = true;
    };

    lint = {
      lintersByFt.haskell = ["hlint"];
    };

    conform-nvim.settings = {
      formatters_by_ft.haskell = ["ormolu"];
    };
  };

  extraPackages = [
    pkgs.haskellPackages.hlint
    pkgs.haskellPackages.ormolu
  ];
}
