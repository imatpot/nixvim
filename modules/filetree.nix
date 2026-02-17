{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkModule' config true "file-tree" {
  performance.combinePlugins.standalonePlugins = ["neo-tree"];
  modules.icons.enable = lib.mkForce true;

  extraPlugins = [
    # {
    #   plugin = pkgs.vimPlugins.fyler;
    #   config = lib.utils.plugins.setup "fyler" {
    #     views = {
    #       explorer = {
    #         win = {
    #           kind = "split_left_most";
    #           buf_opts.buflisted = true;
    #           kind_presets.split_left_most = {
    #             width = 0.2;
    #           };
    #         };
    #
    #         indentscope.marker = "▏";
    #       };
    #     };
    #   };
    # }
  ];

  plugins.neo-tree = {
    enable = true;
    package = pkgs.master.vimPlugins.neo-tree-nvim;

    settings = {
      hide_root_node = true;
      close_if_last_window = true;

      window = {
        width = 48;
      };

      default_component_configs = {
        modified.symbol = "";

        indent = {
          highlight = "NeoTreeIndentMarker2";
        };

        icon = {
          default = "";
          folder_closed = "󰉋";
          folder_empty = "󰉋";
          folder_open = "󰝰";
          folder_empty_open = "󰝰";
        };

        diagnostics.symbols = {
          error = "";
          warn = "";
          info = "";
          hint = "";
        };

        git_status.symbols = {
          added = "";
          conflict = "⚡";
          deleted = "";
          ignored = "";
          modified = "";
          renamed = "";
          staged = "";
          unstaged = "";
          untracked = "";
        };
      };

      filesystem = {
        scan_mode = "deep";
        group_empty_dirs = false;
        follow_current_file.enabled = true;
        use_libuv_file_watcher = true;

        window.mappings = {
          e = "noop";

          n = "add";
          N = "add_directory";

          "<Tab>" = "open";
          ";" = "navigate_up";
          "." = "toggle_hidden";
        };

        filtered_items = {
          show_hidden_count = false;
          hide_dotfiles = false;
          hide_gitignored = false;

          hide_by_name = [
            ".git"
            ".DS_Store"
            "thumbs.db"
            "desktop.ini"
          ];
        };
      };

      renderers = {
        directory = [
          {
            __unkeyed = "indent";
          }
          {
            __unkeyed = "icon";
          }
          {
            __unkeyed = "name";
          }
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
      };

      file = [
        {
          __unkeyed = "indent";
        }
        {
          __unkeyed = "icon";
        }
        {
          __unkeyed = "name";
        }
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

  keymaps = let
    dashboard_refresher = lib.optionalString config.modules.dashboard.enable "<c-w><c-p> <CMD>lua Snacks.dashboard.update()<CR> <c-w><c-p>";
  in
    with lib.utils.keymaps; [
      (mkKeymap' "<leader>e" "<CMD>Neotree focus<CR>${dashboard_refresher}" "Focus file explorer")
      (mkKeymap' "<leader>E" "<CMD>Neotree toggle<CR>${dashboard_refresher}" "Toggle file explorer")
    ];

  autoCmd = [
    # {
    #   event = ["VimEnter"];
    #   pattern = ["*"];
    #   callback =
    #     lib.nixvim.mkRaw
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
