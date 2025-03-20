{
  config,
  lib,
  ...
}:
lib.utils.modules.mkSimple config "snacks" true {
  plugins.snacks = {
    enable = true;

    settings = {
      bigfile.enabled = true;
      quickfile.enabled = true;
      words.enabled = true;
    };
  };
}
