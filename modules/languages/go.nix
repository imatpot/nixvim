{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage' config "go" {
  extraPackages = with pkgs; [
    gotools
  ];

  plugins = {
    lsp.servers.gopls = {
      enable = true;
      packageFallback = true;
    };

    conform-nvim.settings = {
      formatters_by_ft.go = [
        "goimports"
        "gofmt"
      ];

      formatters = {
        goimports.command = lib.getExe' pkgs.gotools "goimports";
        gofmt.command = lib.getExe' pkgs.go "gofmt";
      };
    };

    dap-go.enable = true;
  };
}
