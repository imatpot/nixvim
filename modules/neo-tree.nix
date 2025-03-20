{
  config,
  lib,
  ...
}:
lib.utils.modules.mkSimple config true "neo-tree" {
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
      indent = {
        highlight = "NeoTreeIndentMarker2";
      };

      diagnostics.symbols = {
        error = "E";
        hint = "H";
        info = "I";
        warn = "W";
      };

      gitStatus.symbols = {
        added = "+";
        conflict = "ϟ";
        deleted = "×";
        ignored = "";
        modified = "*";
        renamed = ">";
        staged = "A";
        unstaged = "";
        untracked = "";
      };
    };
  };

  keymaps = [
    {
      key = "<C-e>";
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
}
