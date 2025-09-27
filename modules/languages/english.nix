{
  config,
  lib,
  ...
}:
lib.utils.modules.mkLanguage' config "english" {
  plugins = {
    lsp.servers.harper_ls = {
      enable = true;
      autostart = false;

      settings.harper-ls = {
        dialect = "British";
        isolateEnglish = true;

        linters = {
          Dashes = false;
          PossessiveNoun = true;
          SentenceCapitalization = false; # sometimes i prefer everything to be lowercase
          SpelledNumbers = true;
          UseGenitive = true;
        };
      };
    };
  };
}
