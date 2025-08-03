{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule' config true "todos" {
  plugins.todo-comments = {
    enable = true;
    settings = {
      keywords = {
        FIX.icon = " ";
        HACK.icon = " ";
        NOTE.icon = " ";
        PERF.icon = "⚡";
        TEST.icon = " ";
        TODO.icon = " ";
        WARN.icon = " ";
      };
    };
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "gT" "<CMD>Trouble todo<CR>" "Show TODOs")
  ];
}
