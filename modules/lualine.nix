{
  config,
  lib,
  pkgs,
  ...
}:
lib.utils.modules.mkModule' config true "lualine" {
  performance.combinePlugins.standalonePlugins = ["neo-tree"];

  plugins.lualine = {
    enable = true;
    package = pkgs.master.vimPlugins.lualine-nvim;

    settings = {
      options = {
        always_divide_middle = false;
        globalstatus = true;
        refresh.statusline = 50;

        disabled_filetypes = [
          "snacks_dashboard"
        ];

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
            __unkeyed =
              lib.nixvim.mkRaw
              # lua
              ''
                function()
                  return vim.fn.reg_recording()
                end
              '';

            fmt =
              lib.nixvim.mkRaw
              # lua
              ''
                function(register)
                  return "󰘳"
                end
              '';

            cond =
              lib.nixvim.mkRaw
              # lua
              ''
                function()
                  return vim.fn.reg_recording() ~= ""
                end
              '';
          }
          {
            __unkeyed =
              lib.nixvim.mkRaw
              # lua
              ''
                function()
                  return require('dap').status()
                end
              '';

            fmt =
              lib.nixvim.mkRaw
              # lua
              ''
                function(status)
                  return ""
                end
              '';

            cond =
              lib.nixvim.mkRaw
              # lua
              ''
                function()
                  return package.loaded.dap and require("dap").session() ~= nil
                end
              '';
          }
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
              lib.nixvim.mkRaw
              # lua
              ''
                function()
                  local ignored_filename_patterns = {
                    "^$",
                    "^neo%-tree filesystem %[%d+%]$",
                    "#toggleterm#%d+",
                    "^dap-view%:%/%/.*",
                    "^%[dap%-repl%-%d+%]$",
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
              lib.nixvim.mkRaw
              # lua
              ''
                function()
                  local ignored_filetypes = {
                    "neo-tree",
                    "TelescopePrompt",
                    "TelescopeResults",
                    "toggleterm",
                    "dap-repl",
                    "trouble",
                    "dap-view",
                    "neo-tree-popup",
                    "snacks_dashboard",
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
                lib.nixvim.mkRaw
                # lua
                "BufferLanguageColor()";
            };
            symbols.done = "";
            fmt =
              # lua
              ''
                function(lsp_status)
                  local ignored = {
                    "emmet_language_server",
                  }

                  local seen = {}
                  local unique = {}

                  for ls in lsp_status:gmatch("%S+") do
                    if not seen[ls] and not vim.tbl_contains(ignored, ls) then
                      table.insert(unique, ls)
                      seen[ls] = true
                    end
                  end

                  lsp_status = table.concat(unique, " ")

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
        # "nvim-dap-ui"
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
