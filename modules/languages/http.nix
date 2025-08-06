{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage' config "http" {
  # TODO: enable when https://github.com/NixOS/nixpkgs/pull/385105 is merged

  filetype.extension = {
    http = "http";
    rest = "http";
  };

  plugins = {
    lsp.servers.kulala_ls = {
      enable = false;
      package = null;
      filetypes = ["http"];
    };

    conform-nvim.settings = {
      formatters.kulala-fmt.command = lib.getExe pkgs.kulala-fmt;
      formatters_by_ft.http = ["kulala-fmt"];
    };

    kulala = {
      enable = false;

      settings = {
        global_keymaps = true;
        global_keymaps_prefix = "<localleader>";

        vscode_rest_client_environmentvars = true;
        ui.display_mode = "float";

        icons = {
          lualine = "";
          inlay = {
            loading = "󱥸";
            done = "";
            error = "";
          };
        };
      };
    };
  };

  extraPackages = with pkgs; [
    jq
    grpcurl
    libxml2
  ];
}
