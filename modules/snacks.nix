{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule config true "snacks" {
  plugins.snacks = {
    enable = true;

    settings = {
      bigfile.enabled = true;
      quickfile.enabled = true;
      words.enabled = true;
    };
  };
}
