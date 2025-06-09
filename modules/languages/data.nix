{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage' config "structured data (json, yaml, toml, xml)" {
  plugins = {
    lsp.servers = {
      jsonls.enable = true;
      yamlls.enable = true;
      taplo.enable = true;
      lemminx.enable = true;
      docker_compose_language_service.enable = true;
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
      ];
    };
  };

  extraPackages = with pkgs; [
    # prettierd
    yq-go
  ];
}
