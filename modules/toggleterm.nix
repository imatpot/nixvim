{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkModule config true "toggleterm" {
  plugins.toggleterm = {
    enable = true;
    settings = {
      autochdir = true;
      direction = "float";
      open_mapping = "[[<C-$>]]";
      float_opts.border = "curved";
    };
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<leader>g" "<CMD>lua ToggleGitUi()<CR>" "Toggle GitUI")
  ];

  extraConfigLuaPre = builtins.readFile ./toggleterm.lua;

  extraPackages = with pkgs; [
    gitui
  ];
}
