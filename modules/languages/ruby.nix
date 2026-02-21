{
  config,
  lib,
  ...
}:
lib.utils.modules.mkLanguage' config "ruby" {
  withRuby = true;

  plugins = {
    lsp.servers.solargraph = {
      enable = true;
      packageFallback = true;
    };

    lint.lintersByFt.ruby = ["ruby"];
  };

  filetype.filename = {
    Fastfile = "ruby";
    Appfile = "ruby";
  };
}
