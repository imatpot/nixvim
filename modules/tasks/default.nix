{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkModule' config true "tasks" {
  plugins.overseer = {
    enable = true;
    luaConfig.post = builtins.readFile ./tasks.lua;
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<leader>xx" "<CMD>OverseerToggle<CR>" "Open task runner")
    (mkKeymap' "<leader>xs" "<CMD>OverseerRun<CR>" "Run task")
    (mkKeymap' "<leader>xS" "<CMD>lua OverseerRunAndOpen()<CR>" "Run task and open task runner")

    (mkKeymap' "<leader>xns" "<CMD>Telescope nx actions<CR>" "Nx run")
    (mkKeymap' "<leader>xna" "<CMD>Telescope nx affected<CR>" "Nx affected")
    (mkKeymap' "<leader>xng" "<CMD>Telescope nx generators<CR>" "Nx generate")
    (mkKeymap' "<leader>xnGe" "<CMD>Telescope nx external_generators<CR>" "Nx workspace generators")
    (mkKeymap' "<leader>xnGw" "<CMD>Telescope nx workspace_generators<CR>" "Nx workspace generators")
    (mkKeymap' "<leader>xnm" "<CMD>Telescope nx run_many<CR>" "Nx run many")
  ];

  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = nx-nvim;
      config = lib.utils.plugins.setup "nx" {
        nx_cmd_root = "npx nx";
      };
    }
  ];
}
