{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule config true "tasks" {
  plugins.overseer = {
    enable = true;
    luaConfig.post = builtins.readFile ./tasks.lua;
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<leader>xx" "<CMD>OverseerToggle<CR>" "Open task runner")
    (mkKeymap' "<leader>xs" "<CMD>OverseerRun<CR>" "Run task")
    (mkKeymap' "<leader>xS" "<CMD>lua OverseerRunAndOpen()<CR>" "Run task")
  ];
}
