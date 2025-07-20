{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage' config "markdown" {
  performance.combinePlugins.standalonePlugins = ["helpview.nvim" "markview.nvim"];

  plugins = {
    lsp.servers.marksman.enable = true;

    conform-nvim.settings = {
      formatters_by_ft.markdown = ["deno_fmt"];
    };

    lint = {
      lintersByFt.markdown = ["markdownlint-cli2"];
    };

    markview.enable = true;
    helpview.enable = true;
  };

  files."ftplugin/markdown.lua" = {
    opts = {
      wrap = true;
    };

    keymaps = with lib.utils.keymaps; [
      (mkBufferKeymap' "<localleader>p" "<CMD>Markview<CR>" "Toggle Markview")
    ];
  };

  extraPackages = with pkgs; [
    # can't use linters.markdownlint-cli2.cmd because Lua shits itself due to the "-" in the name
    markdownlint-cli2
  ];
}
