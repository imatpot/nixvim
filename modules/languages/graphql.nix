{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage' config "graphql" {
  plugins = {
    lsp.servers.graphql = {
      enable = true;
      packageFallback = true;

      package = pkgs.graphql-language-service-cli;
    };

    conform-nvim.settings = {
      formatters.prettierd.command = lib.getExe pkgs.prettierd;
      formatters_by_ft.graphql = ["prettierd"];
    };
  };
}
