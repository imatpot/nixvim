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
                  if branch ~= "" then
                    return "git:" .. branch
                  end

                  return branch
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
            cond =
              helpers.mkRaw
              # lua
              ''
                function()
                  local ignored_filename_patterns = {
                    "^Unnamed$",
                    "^neo%-tree filesystem %[%d+%]$",
                    "#toggleterm#%d+",
                  }

                  local filename = vim.fn.expand("%:t")

                  for _, pattern in ipairs(ignored_filename_patterns) do
                    if string.find(filename, pattern) then
                      return false
                    end
                  end

                  return true
                end
              '';
          }
          "diff"
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
          {
            __unkeyed = "filetype";
            cond =
              helpers.mkRaw
              # lua
              ''
                function()
                  local ignored_filetypes = {
                    "neo-tree",
                    "TelecopePrompt",
                    "toggleterm",
                  }

                  return not vim.tbl_contains(ignored_filetypes, vim.bo.filetype)
                end
              '';
          }
          {
            __unkeyed = "lsp_status";
            ignore_lsp = ["copilot"];
            icon = {
              __unkeyed = "󰗊";
              # TODO: lualine doesn't update this color on refresh, it only runs once
              color.fg =
                helpers.mkRaw
                # lua
                "BufferLanguageColor()";
            };
            symbols.done = "";
            fmt =
              # lua
              ''
                function(lsp_status)
                  -- otter-ls has stuff after it, so i can't use ignore_lsp
                  return lsp_status:gsub("otter%-ls%[.+%]", ""):gsub("%s+$", "")
                end
              '';
          }
          {
            __unkeyed = "encoding";
            padding = {
              left = 1;
              right = 2;
            };
          }
        ];

        lualine_y = [
          {
            __unkeyed = "searchcount";
            padding.right = 2;
          }
          {
            __unkeyed = "selectioncount";
            padding.right = 2;
          }
          # {
          #   __unkeyed = "progress";
          #   padding.right = 2;
          #   fmt =
          #     # lua
          #     ''
          #       function(progress)
          #         if progress == "Top" then
          #           return "TOP"
          #         end

          #         if progress == "Bot" then
          #           return "END"
          #         end

          #         return progress
          #       end
          #     '';
          # }
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

    luaConfig.pre =
      # lua
      ''
        local devicons = require("nvim-web-devicons");

        function BufferLanguageColor()
          local filename = vim.fn.expand("%:t")
          local _, color = devicons.get_icon_color(filename)
          return color
        end
      '';
  };
}
