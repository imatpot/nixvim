{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkModule' config false "kakoune" {
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = kak-nvim;
      config = lib.utils.plugins.setup "kak" {
        full = true;
        which_key_integration = true;
        experimental.rebind_visual_aiAI = true;
      };
    }
  ];
}
