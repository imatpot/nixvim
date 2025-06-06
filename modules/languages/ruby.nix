{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkLanguage' config "ruby" {
  withRuby = true;

  plugins = {
    lsp.servers.solargraph.enable = true;
    lint.lintersByFt.ruby = ["ruby"];
    conform-nvim.settings.formatters_by_ft.ruby.lsp_format = "prefer";
  };

  filetype.filename = {
    Fastfile = "ruby";
    Appfile = "ruby";
  };
}
