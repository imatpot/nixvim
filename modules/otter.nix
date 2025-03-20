{
  config,
  lib,
  ...
}:
lib.utils.modules.mkSimple config true "otter" {
  plugins.otter = {
    enable = true;
    settings.handle_leading_whitespace = true;
  };
}
