{
  config,
  lib,
  helpers,
  ...
}: {
  options = {
    modules.neo-tree.enable = lib.mkEnableOption "neo-tree";
  };

  config = lib.mkIf config.modules.neo-tree.enable {
    modules.icons.enable = true;

    plugins.neo-tree = {
      enable = true;
      hideRootNode = true;
      closeIfLastWindow = true;

      filesystem = {
        window.mappings = {
          n = "add";
          N = "add_directory";

          "<Tab>" = "open";
          ";" = "navigate_up";
          "." = "toggle_hidden";
        };

        filteredItems = {
          hideDotfiles = false;
          hideGitignored = false;

          hideByName = [".git"];
        };
      };
    };

    keymaps = [
      {
        key = "<leader>e";
        action = "<CMD>Neotree toggle<CR>";
        options.desc = "Toggle file explorer";
      }
    ];

    autoCmd = [
      # {
      #   event = ["VimEnter"];
      #   pattern = ["*"];
      #   callback = helpers.mkRaw ''
      #     function()
      #       if (vim.fn.expand("%") == "") then
      #         require('neo-tree.command').execute({})
      #       end
      #     end
      #   '';
      # }
    ];
  };
}
