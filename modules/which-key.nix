{
  config,
  lib,
  ...
}:
lib.utils.modules.mkSimple config true "which-key" {
  plugins.which-key = {
    enable = true;
    settings = {
      preset = "helix";
      delay = 500;
      icons.mappings = false;
    };
  };
}
