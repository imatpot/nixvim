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

    conform-nvim.settings.formatters_by_ft = {
      html = ["prettierd"];
      css = ["prettierd"];
    };
  };

  extraPackages = with pkgs; [
    prettierd
    # htmlhint
    # stylelint
  ];
}
