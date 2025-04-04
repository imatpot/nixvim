{
  config,
  lib,
  helpers,
  pkgs,
  ...
}:
lib.utils.modules.mkModule config true "lualine" {
  plugins.lualine = {
    enable = true;
    package = pkgs.master.vimPlugins.lualine-nvim;

    settings = {
      options = {
        always_divide_middle = false;
        disabled_filetypes = ["snacks_dashboard"];
        globalstatus = true;

        component_separators = {
          left = "";
          right = "";
        };

        section_separators = {
          left = "";
          right = "";
        };
      };

      sections = {
        lualine_a = [
          {
            __unkeyed = "mode";
            fmt =
              # lua
              ''
                function(mode)
                  return mode:sub(1, 1):upper()
                end
              '';
          }
        ];

        lualine_b = [
          {
            __unkeyed = "branch";
            icon = "";
            fmt =
              # lua
              ''
                function(branch)
                  return "git:" .. branch
                end
              '';
          }
        ];

        lualine_c = [
          {
            __unkeyed = "filename";
            path = 1;
            symbols = {
              modified = "•";
              readonly = "󰏯 ";
              unnamed = "Unnamed";
              newfile = "New file";
            };
          }
          "diff"
          # {
          #   __unkeyed = "diff";
          #   source =
          #     # lua
          #     ''
          #       function()
          #         local gitsigns = vim.b.gitsigns_status_dict
          #         if gitsigns then
          #           return {
          #             added = gitsigns.added,
          #             modified = gitsigns.changed,
          #             removed = gitsigns.removed,
          #           }
          #         end
          #       end
          #     '';
          # }
          {
            __unkeyed = "diagnostics";
            symbols = {
              error = " ";
              warn = " ";
              info = " ";
              hint = " ";
            };
          }
        ];

        lualine_x = [
          "filetype"
          {
            __unkeyed = "lsp_status";
            ignore_lsp = ["copilot"];
            fmt =
              # lua
              ''
                function(lsp_status)
                  return lsp_status:gsub("otter%-ls%[.+%]", ""):gsub("%s+$", "")
                end
              '';
          }
          "encoding"
        ];

        lualine_y = [
          {
            __unkeyed = "progress";
            padding = {
              right = 2;
              left = 1;
            };
            fmt =
              # lua
              ''
                function(progress)
                  if progress == "Top" then
                    return "top"
                  end

                  if progress == "Bot" then
                    return "end"
                  end

                  return progress
                end
              '';
          }
        ];

        lualine_z = [
          {
            __unkeyed = "location";
            padding = {
              left = 1;
              right = 2;
            };
          }
        ];
      };

      extensions = [
        "nvim-dap-ui"
        "overseer"
        "symbols-outline"
      ];
    };
  };
}
