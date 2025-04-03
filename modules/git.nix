{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule config true "git" {
  modules.telescope.enable = true;

  plugins = {
    gitignore.enable = true;

    gitsigns = {
      enable = true;

      settings = {
        signs = {
          # TODO: 🮇 is not full height in many fonts
          add.text = "▐";
          change.text = "▐";
        };

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

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<leader>G" "<CMD>Gitignore<CR>" "Generate .gitignore")
  ];
}
