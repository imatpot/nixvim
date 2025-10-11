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
          delay = 0;
        };
      };
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    telescope-git-conflicts
  ];

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<leader>Gi" "<CMD>Gitignore<CR>" "Generate .gitignore")
    (mkKeymap' "<leader>Gb" "<CMD>Gitsigns toggle_current_line_blame<CR>" "Toggle line blame")

    (mkKeymap' "<leader>Gcl" "<CMD>GitConflictChooseOurs<CR>" "Keep local change")
    (mkKeymap' "<leader>Gcr" "<CMD>GitConflictChooseTheirs<CR>" "Keep remote change")
    (mkKeymap' "<leader>Gcb" "<CMD>GitConflictChooseBoth<CR>" "Keep both changes")
    (mkKeymap' "<leader>Gcq" "<CMD>GitConflictChooseNone<CR>" "Discard both changes")
    (mkKeymap' "<leader>Gck" "<CMD>GitConflictPrevConflict<CR>" "Go to previous conflict")
    (mkKeymap' "<leader>Gc<up>" "<CMD>GitConflictPrevConflict<CR>" "Go to previous conflict")
    (mkKeymap' "<leader>Gcj" "<CMD>GitConflictNextConflict<CR>" "Go to next conflict")
    (mkKeymap' "<leader>Gc<down>" "<CMD>GitConflictNextConflict<CR>" "Go to next conflict")

    (mkKeymap' "<leader>Gc/" "<CMD>Telescope conflicts<CR>" "Find conflicted files")
  ];
}
