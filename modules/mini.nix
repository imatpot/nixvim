{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule config true "mini" {
  modules.icons.enable = lib.mkForce true;

  plugins.mini = {
    enable = true;

    modules = {
      pairs.enabled = true;
      trailspace.enabled = true;

      comment = {
        enabled = true;
        mappings = {
          comment = "C";
          comment_line = "<leader>c";
          comment_visual = "<leader>c";
          textobject = "c";
        };
      };

      surround = {
        enabled = true;
        silent = true;
      };
    };
  };
}
