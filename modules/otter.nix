{
  config,
  lib,
  ...
}:
lib.utils.modules.mkSimple config "otter" true {
  plugins.otter = {
    enable = true;
    settings.handle_leading_whitespace = true;
  };
}
