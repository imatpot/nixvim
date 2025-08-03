{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule' config true "hop" {
  plugins.hop = {
    enable = true;

    settings = {
      keys = "asdfghjklqwertzuiopyxcvbnm";
      teasing = false;
    };
  };

  keymaps = [
    {
      key = "f";
      action = "<CMD>silent! HopPattern<CR>";
      options.desc = "Hop to pattern";
    }
    {
      key = "F";
      action = "<CMD>silent! HopAnywhere<CR>";
      options.desc = "Hop";
    }
  ];
}
