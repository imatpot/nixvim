{
  pkgs,
  utils,
  ...
}: {
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = kak-nvim;
      config = utils.luaToViml ''
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
