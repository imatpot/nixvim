{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkSimple config true "toggleterm" {
  plugins.toggleterm = {
    enable = true;
    settings = {
      autochdir = true;
      direction = "float";
      open_mapping = "[[<C-$>]]";
      float_opts.border = "curved";
    };
  };

  extraConfigLuaPre = ''
    local Terminal  = require('toggleterm.terminal').Terminal
      local gitui = Terminal:new({
        cmd = "${lib.getExe pkgs.gitui}",
        direction = "float",
        float_opts = {
          border = "curved",
        },
        hidden = true,
      })

    function ToggleGitUi()
      gitui:toggle()
    end
  '';

  keymaps = [
    {
      key = "<C-g>";
      action = "<CMD>lua ToggleGitUi()<CR>";
      options.desc = "Toggle GitUI";
    }
  ];
  extraPackages = with pkgs; [
    gitui
  ];
}
