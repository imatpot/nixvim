{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule' config true "hop" {
  plugins.hop.enable = true;

  keymaps = [
    {
      key = "f";
      action = "<CMD>HopPattern<CR>";
      options.desc = "Hop to pattern";
    }
    {
      key = "F";
      action = "<CMD>HopAnywhere<CR>";
      options.desc = "Hop";
    }
  ];
}
