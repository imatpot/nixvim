{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage' config "prisma" {
  plugins = {
    lsp.servers = {
      prismals = {
        enable = true;
        package = pkgs.prisma-language-server;
        packageFallback = true;
      };
    };
  };
}
