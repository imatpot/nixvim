{
  config,
  lib,
  ...
}:
lib.utils.modules.mkLanguage' config "english" {
  plugins = {
    lsp.servers.harper_ls = {
      enable = true;
      packageFallback = true;

      autostart = false;

      settings.harper-ls = {
        dialect = "British";
        isolateEnglish = true;

        linters = {
          OxfordComma = true; # my beloved

          Dashes = false;
          LongSentences = false;
          PossessiveNoun = true;
          SentenceCapitalization = false;
          SpelledNumbers = true;
          UseGenitive = true;
        };
      };
    };
  };
}
