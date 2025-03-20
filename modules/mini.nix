{
  config,
  lib,
  ...
}: {
  options = {modules.mini.enable = lib.utils.mkDefaultEnableOption true "mini suite";};

  config = lib.mkIf config.modules.mini.enable {
    modules.icons.enable = lib.mkForce true;

    plugins.mini = {
      enable = true;

      modules = {
        pairs.enabled = true;
        comment.enabled = true;
        align.enabled = true;
        move.enabled = true;
        trailspace.enabled = true;

        surround = {
          denabled = true;
          silent = true;
        };
      };
    };

    keymaps = [
      {
        key = "<leader>c";
        action = ''<CMD>lua MiniComment.toggle_lines(vim.fn.line("."), vim.fn.line("."))<CR>'';
        mode = "n";
        options.desc = "Toggle comment";
      }
      {
        key = "<leader>c";
        action = ''<CMD>lua MiniComment.toggle_visual()<CR>'';
        mode = "v";
        options.desc = "Toggle comment";
      }
    ];
  };
}
