{
  config,
  lib,
  ...
}:
lib.utils.modules.mkSimple config "which-key" true {
  plugins.which-key = {
    enable = true;
    settings = {
      preset = "helix";
      delay = 500;
      icons.mappings = false;
    };
  };
}
