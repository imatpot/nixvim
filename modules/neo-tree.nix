{
  config,
  lib,
  ...
}:
lib.utils.modules.mkModule config true "neo-tree" {
  modules.icons.enable = lib.mkForce true;

  plugins.neo-tree = {
    enable = true;
    hideRootNode = true;
    closeIfLastWindow = true;

    filesystem = {
      scanMode = "deep";
      groupEmptyDirs = true;
      followCurrentFile.enabled = true;

      window.mappings = {
        n = "add";
        N = "add_directory";

        "<Tab>" = "open";
        ";" = "navigate_up";
        "." = "toggle_hidden";
      };

      filteredItems = {
        showHiddenCount = false;
        hideDotfiles = false;
        hideGitignored = false;

        hideByName = [".git"];
      };
    };

    defaultComponentConfigs = {
      modified.symbol = "•";

      indent = {
        highlight = "NeoTreeIndentMarker2";
      };

      diagnostics.symbols = {
        error = "";
        warn = "";
        info = "";
        hint = "";
      };

      gitStatus.symbols = {
        added = "+";
        conflict = "ϟ";
        deleted = "×";
        ignored = "";
        modified = "*";
        renamed = "»";
        staged = "S";
        unstaged = "";
        untracked = "";
      };
    };

    renderers = {
      directory = [
        "indent"
        "icon"
        "name"
        {
          name = "container";
          content = [
            {
              name = "git_status";
              align = "right";
              hide_when_expanded = true;
              zindex = 10;
            }
            {
              name = "diagnostics";
              align = "right";
              errors_only = true;
              hide_when_expanded = true;
              zindex = 10;
            }
          ];
        }
      ];

      file = [
        "indent"
        "icon"
        "name"
        {
          name = "container";
          content = [
            {
              name = "modified";
              align = "right";
              zindex = 10;
            }
            {
              name = "git_status";
              align = "right";
              zindex = 10;
            }
            {
              name = "diagnostics";
              align = "right";
              zindex = 10;
            }
          ];
        }
      ];
    };
  };

  keymaps = with lib.utils.keymaps; [
    (mkKeymap' "<leader>e" "<CMD>Neotree focus<CR>" "Focus file explorer")
    (mkKeymap' "<leader>E" "<CMD>Neotree toggle<CR>" "Toggle file explorer")
  ];

  autoCmd = [
    # {
    #   event = ["VimEnter"];
    #   pattern = ["*"];
    #   callback =
    #     helpers.mkRaw
    #     # lua
    #     ''
    #     function()
    #       if (vim.fn.expand("%") == "") then
    #         require('neo-tree.command').execute({})
    #       end
    #     end
    #   '';
    # }
  ];
}
