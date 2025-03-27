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

  extraConfigLuaPre =
    # lua
    ''
      Terminal = require('toggleterm.terminal').Terminal

      GitUi = Terminal:new({
        cmd = "${lib.getExe pkgs.gitui}",
        direction = "float",
        float_opts = {
          border = "curved",
        },
        hidden = true,
      })

      function ToggleGitUi()
        GitUi:toggle()
      end
    '';

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<leader>g" "<CMD>lua ToggleGitUi()<CR>" "Toggle GitUI")
  ];

  extraPackages = with pkgs; [
    gitui
  ];
}
