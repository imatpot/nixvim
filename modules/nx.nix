{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkModule config true "nx" {
  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = nx-nvim;
      config =
        lib.utils.viml.fromLua
        # lua
        ''
          require("nx").setup({
            nx_cmd_root = "npx nx",
          })
        '';
    }
  ];

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<leader>xNa" "<CMD>Telescope nx actions<CR>" "Actions")
    (mkKeymap' "<leader>xNA" "<CMD>Telescope nx affected<CR>" "Affected")
    (mkKeymap' "<leader>xNg" "<CMD>Telescope nx generators<CR>" "Generate")
    (mkKeymap' "<leader>xNGe" "<CMD>Telescope nx external_generators<CR>" "Workspace generators")
    (mkKeymap' "<leader>xNGw" "<CMD>Telescope nx workspace_generators<CR>" "Workspace generators")
    (mkKeymap' "<leader>xNm" "<CMD>Telescope nx run_many<CR>" "Run many")
  ];
}
