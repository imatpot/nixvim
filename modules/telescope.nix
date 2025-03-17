{
  config,
  lib,
  pkgs,
  helpers,
  ...
}: {
  options = {
    modules.telescope.enable = lib.mkEnableOption "telescope";
  };

  config = lib.mkIf config.modules.telescope.enable {
    plugins.telescope = {
      enable = true;

      settings.defaults.mappings.i."<esc>" = helpers.mkRaw "require('telescope.actions').close";

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
        config = lib.utils.viml.fromLua ''
          local builtin = require('telescope.builtin')
          require('search').setup({
            initial_tab = 1,
            tabs = {
              { name = "Files", tele_func = builtin.find_files },
              { name = "Grep", tele_func = builtin.live_grep },
            }
          })
        '';
      }
    ];

    keymaps = [
      {
        key = "<leader>p";
        action = "<CMD>lua require('search').open()<CR>";
        options.desc = "Search files";
        mode = "n";
      }
      {
        key = "<leader>P";
        action = "<CMD>lua require('search').open()<CR>";
        options.desc = "Grep files";
        mode = "n";
      }
    ];

    extraPackages = with pkgs; [
      ripgrep
    ];
  };
}
