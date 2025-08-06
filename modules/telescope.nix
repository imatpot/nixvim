{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkModule' config true "telescope" {
  plugins.telescope = {
    enable = true;

    settings.defaults = {
      mappings.i."<esc>" = lib.nixvim.mkRaw "require('telescope.actions').close";

      file_ignore_patterns = [
        "^%.dart_tool/"
        "^%.git/"
        "^%.venv/"
        "^%.angular/"
        "^node_modules/"
        "^venv/"
      ];

      vimgrep_arguments = [
        "rg"
        "-uuu"
        "--hidden"
        "--color=never"
        "--no-heading"
        "--with-filename"
        "--line-number"
        "--column"
        "--smart-case"
        "--trim"
      ];

      pickers = {
        find_files.find_command = [
          "rg"
          "-uuu"
          "--files"
          "--hidden"
          "--glob"
          "!**/.git/*"
        ];
      };
    };

    extensions = {
      ui-select = {
        enable = true;
        settings = {
          __unkeyed_1 = lib.nixvim.mkRaw "require('telescope.themes').get_cursor()";
        };
      };
    };
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<leader>p" "<CMD>Telescope find_files hidden=true<CR>" "Search files")
    (mkKeymap' "<leader>/" "<CMD>Telescope live_grep<CR>" "Grep files")

    (mkKeymap' "gi" "<CMD>Telescope lsp_implementations<CR>" "Go to implementations")
    (mkKeymap' "gd" "<CMD>Telescope lsp_definitions<CR>" "Go to definitions")
    (mkKeymap' "gr" "<CMD>Telescope lsp_references<CR>" "Go to references")
    (mkKeymap' "gt" "<CMD>Telescope lsp_type_definitions<CR>" "Go to type definitions")
  ];

  extraPackages = with pkgs; [
    ripgrep
  ];
}
