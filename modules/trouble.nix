{
  config,
  lib,
  ...
}:
lib.utils.modules.mkSimple config true "trouble" {
  plugins.trouble.enable = true;

  files."ftplugin/Trouble.lua".opts.wrap = true;

  keymaps = [
    {
      key = "<Leader>t";
      action = "<CMD>Trouble diagnostics toggle<CR>";
      options.desc = "Toggle diagnostics";
    }
  ];
}
