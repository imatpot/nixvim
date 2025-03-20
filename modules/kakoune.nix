{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkSimple config false "kakoune" {
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = kak-nvim;
      config = lib.utils.viml.fromLua ''
        require("kak").setup({
          full = true,
          which_key_integration = true,

          experimental = {
            rebind_visual_aiAI = true,
          }
        })
      '';
    }
  ];
}
