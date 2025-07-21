{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkModule' config true "git" {
  modules.telescope.enable = true;

  plugins = {
    gitignore.enable = true;

    git-conflict = {
      enable = true;
      settings.default_mappings = false;
    };

    gitsigns = {
      enable = true;

      settings = {
        signs = {
          # TODO: 🮇 is not full height in many fonts
          add.text = "▐";
          change.text = "▐";
        };

        current_line_blame = true;
        current_line_blame_formatter = " <author>, <author_time:%R> - <summary> ";
        current_line_blame_formatter_nc = " Uncommitted change ";
        current_line_blame_opts = {
          virt_text = true;
          virt_text_pos = "right_align";
          delay = 1000;
        };
      };
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    plenary-nvim
    telescope-git-conflicts
  ];

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<leader>G" "<CMD>Gitignore<CR>" "Generate .gitignore")
    (mkKeymap' "<localleader>gi" "<CMD>Gitignore<CR>" "Generate .gitignore")

    (mkKeymap' "<localleader>gcl" "<CMD>GitConflictChooseOurs<CR>" "Keep local change")
    (mkKeymap' "<localleader>gcr" "<CMD>GitConflictChooseTheirs<CR>" "Keep remote change")
    (mkKeymap' "<localleader>gcb" "<CMD>GitConflictChooseBoth<CR>" "Keep both changes")
    (mkKeymap' "<localleader>gcq" "<CMD>GitConflictChooseNone<CR>" "Discard both changes")
    (mkKeymap' "<localleader>gck" "<CMD>GitConflictPrevConflict<CR>" "Go to previous conflict")
    (mkKeymap' "<localleader>gc<up>" "<CMD>GitConflictPrevConflict<CR>" "Go to previous conflict")
    (mkKeymap' "<localleader>gcj" "<CMD>GitConflictNextConflict<CR>" "Go to next conflict")
    (mkKeymap' "<localleader>gc<down>" "<CMD>GitConflictNextConflict<CR>" "Go to next conflict")

    (mkKeymap' "<localleader>gc/" "<CMD>Telescope conflicts<CR>" "Find conflicted files")
  ];
}
