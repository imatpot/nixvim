{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage' config "web (html, css)" {
  plugins = {
    lsp.servers = {
      html.enable = true;
      cssls.enable = true;
      emmet_language_server.enable = true;
      tailwindcss.enable = true;
    };

    # FIXME: these linters are, like, really annoying
    # lint = {
    #   lintersByFt = rec {
    #     html = ["htmlhint"];
    #     css = ["stylelint"];
    #     scss = css;
    #     sass = css;
    #     less = css;
    #   };
    #
    #   linters.htmlhint.args = [
    #     "stdin"
    #     "--format"
    #     "compact"
    #     "--config"
    #     "${./config/.htmlhintrc}"
    #   ];
    # };

    conform-nvim.settings.formatters_by_ft = rec {
      html = ["prettierd"];
      htmlangular = html;

      css = ["prettierd"];
    };
  };

  extraPackages = with pkgs; [
    prettierd
    # htmlhint
    # stylelint
  ];

  files."ftplugin/html.lua" = {
    keymaps = with lib.utils.keymaps; [
      (mkBufferKeymap' "<localleader>v" "<CMD>Markview<CR>" "Toggle Markview")
    ];
  };
}
