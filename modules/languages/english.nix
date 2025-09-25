{
  config,
  lib,
  ...
}:
lib.utils.modules.mkLanguage' config "english" {
  plugins = {
    lsp.servers.harper_ls = {
      enable = true;
      settings = {
        dialect = "British";
        isolateEnglish = true;

        linters = {
          SentenceCapitalization = false; # sometimes i prefer everything to be lowercase
          SpelledNumbers = true;
          UseGenitive = true;
          PossessiveNoun = true;
        };
      };
    };
  };
}
