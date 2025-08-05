{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage' config "structured data (json, yaml, toml, xml, csv)" {
  plugins = {
    lsp.servers = {
      jsonls.enable = true;
      yamlls.enable = true;
      taplo.enable = true;
      lemminx.enable = true;
    };

    conform-nvim.settings = {
      formatters.prettierd.command = lib.getExe pkgs.prettierd;

      formatters_by_ft = {
        json = ["prettierd"];
        yaml = ["prettierd"];
        toml = ["taplo"];
        xml = ["xmllint"];
      };
    };

    ts-autotag.enable = true;

    csvview = {
      enable = true;
      settings = {
        view.display_mode = "border";
        parser.comments = ["//" "#" "--"];

        keymaps = {
          jump_next_field_end = {
            __unkeyed-1 = "<Tab>";
            mode = ["n" "v"];
          };

          jump_prev_field_start = {
            __unkeyed-1 = "<S-Tab>";
            mode = ["n" "v"];
          };

          jump_next_row = {
            __unkeyed-1 = "<Enter>";
            mode = ["n" "v"];
          };

          jump_prev_row = {
            __unkeyed-1 = "<S-Enter>";
            mode = ["n" "v"];
          };
        };
      };
    };
  };

  files = {
    "ftplugin/json.vim" = {
      keymaps = with lib.utils.keymaps; [
        (mkBufferKeymap' "<localleader>s" "<CMD>%!jq -S<CR>" "Sort")
        (mkBufferKeymap' "<localleader>S" "<CMD>%!jq -S<CR><CMD>w<CR>" "Sort and save")
      ];
    };

    "ftplugin/yaml.vim" = {
      keymaps = with lib.utils.keymaps; [
        (mkBufferKeymap' "<localleader>s" "<CMD>%!yq eval 'sort_keys(..)' -<CR>" "Sort")
        (mkBufferKeymap' "<localleader>S" "<CMD>%!yq eval 'sort_keys(..)' -<CR><CMD>w<CR>" "Sort and save")
        (mkBufferKeymap' "<localleader>v" "<CMD>Markview<CR>" "Toggle Markview")
      ];
    };

    "ftplugin/csv.vim" = {
      keymaps = with lib.utils.keymaps; [
        (mkBufferKeymap' "<localleader>v" "<CMD>CsvViewToggle<CR>" "View as table")
      ];
    };
  };

  extraPackages = with pkgs; [
    # prettierd
    yq-go
  ];
}
