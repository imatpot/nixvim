{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage' config "markdown" {
  performance.combinePlugins.standalonePlugins = ["helpview.nvim" "markview.nvim"];

  plugins = {
    lsp.servers.marksman = {
      enable = true;
      packageFallback = true;
    };

    conform-nvim.settings = {
      formatters_by_ft.markdown = ["deno_fmt"];
      formatters.deno_fmt.append_args = lib.concatLists [
        ["--line-width" "2147483647"]
        ["--prose-wrap" "preserve"]
      ];
    };

    helpview.enable = true;

    markview = {
      enable = true;
      settings.preview.enable = false;
    };
  };

  files."ftplugin/markdown.lua" = {
    opts = {
      wrap = true;
    };

    keymaps = with lib.utils.keymaps; [
      (mkBufferKeymap' "<localleader>v" "<CMD>Markview<CR>" "Toggle Markview")
    ];
  };

  extraPackages = with pkgs; [
    # can't use linters.markdownlint-cli2.cmd because Lua shits itself due to the "-" in the name
    markdownlint-cli2
  ];
}
