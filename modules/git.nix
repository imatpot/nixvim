{
  config,
  lib,
  ...
}:
lib.utils.modules.mkSimple config true "git" {
  plugins = {
    gitsigns = {
      enable = true;

      settings = {
        current_line_blame = true;
        current_line_blame_formatter = "<author>, <author_time:%R> - <summary>";
        current_line_blame_opts = {
          virt_text = true;
          virt_text_pos = "right_align";
          delay = 1000;
        };
      };
    };
  };
}
