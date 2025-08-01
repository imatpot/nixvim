{
  config,
  lib,
  pkgs,
  helpers,
  ...
}:
lib.utils.modules.mkModule' config true "telescope" {
  plugins.telescope = {
    enable = true;

    settings.defaults = {
      mappings.i."<esc>" = helpers.mkRaw "require('telescope.actions').close";

      file_ignore_patterns = [
        "^node_modules/"
        "^venv/"
        "^.venv/"
      ];
    };

    extensions = {
      ui-select.enable = true;
      file-browser.enable = true;
      fzy-native = {
        enable = true;
        settings = {
          override_file_sorter = true;
          override_generic_sorter = true;
        };
      };
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = search;
      config =
        lib.utils.viml.fromLua
        # lua
        ''
          local builtin = require('telescope.builtin')
          require('search').setup({
            initial_tab = 1,
            tabs = {
              { name = "Files", tele_func = builtin.find_files },
              { name = "Grep", tele_func = builtin.live_grep },
              { name = "Buffers", tele_func = builtin.buffers },
            }
          })
        '';
    }
  ];

  keymaps = let
    search = "lua require('search')";
    teleOpts =
      # lua
      ''
        tele_opts = {
          no_ignore = true,
          no_ignore_parent = true,
          hidden = true,
          use_regex = true,
          file_ignore_patterns = {
            "^.git/",
            "^node_modules/",
            "^.dart_tool/",
          },
        }
      '';
  in
    with lib.utils.keymaps; [
      (mkKeymap' "<leader>p" "<CMD>${search}.open({ tab_name = 'Files', ${teleOpts} })<CR>" "Search files")
      (mkKeymap' "<leader>/" "<CMD>${search}.open({ tab_name = 'Grep', ${teleOpts} })<CR>" "Grep files")

      (mkKeymap' "gi" "<CMD>Telescope lsp_implementations<CR>" "Go to implementations")
      (mkKeymap' "gd" "<CMD>Telescope lsp_definitions<CR>" "Go to definitions")
      (mkKeymap' "gr" "<CMD>Telescope lsp_references<CR>" "Go to references")
      (mkKeymap' "gt" "<CMD>Telescope lsp_type_definitions<CR>" "Go to type definitions")
    ];

  extraPackages = with pkgs; [
    ripgrep
  ];
}
