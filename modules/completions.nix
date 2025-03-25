{
  config,
  lib,
  helpers,
  pkgs,
  ...
}: {
  options = {
    modules.completions = {
      enable = lib.utils.mkDefaultEnableOption true "completions";
      unicode.enable = lib.utils.mkDefaultEnableOption config.modules.completions.enable "unicode";
      copilot.enable = lib.utils.mkDefaultEnableOption config.modules.completions.enable "copilot";
    };
  };

  config = let
    mkSources = sources:
      map (source:
        if lib.isAttrs source
        then source
        else {
          name = source;
          group_index = 2;
        })
      sources;
  in
    lib.mkIf config.modules.completions.enable {
      plugins = {
        luasnip.enable = true;

        cmp = {
          enable = true;
          autoEnableSources = true;

          cmdline = let
            mapping =
              helpers.mkRaw
              # lua
              "cmp.mapping.preset.cmdline()";
          in {
            ":" = {
              inherit mapping;
              sources = mkSources [
                "path"
                "cmdline"
                "cmdline_history"
              ];
            };

            "/" = {
              inherit mapping;
              sources = mkSources [
                "buffer"
                "cmdline_history"
                "nvim_lsp_document_symbol"
              ];
            };

            "?" = {
              inherit mapping;
              sources = mkSources [
                "cmdline_history"
              ];
            };
          };

          filetype = let
            dapSources = mkSources ["dap"];
          in {
            dap-repl.sources = dapSources;
            dapui_hover.sources = dapSources;
            dapui_watches.sources = dapSources;
          };

          settings = {
            preselect = "cmp.PreselectMode.None";

            matching.disallowPartialFuzzyMatching = false;
            snippet.expand = "function(args) luasnip.lsp_expand(args.body) end";

            formatting = {
              fields = ["kind" "abbr" "menu"];
              format =
                # lua
                ''
                  function(entry, vim_item)
                    local format = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)

                    local strings = vim.split(format.kind, "%s", { trimempty = true })
                    local icon = strings[1] or ""
                    local description = strings[2] or ""

                    local description_delim = ""
                    if description ~= "" then
                      description_delim = "."
                    end

                    format.menu = "    " .. entry.source.name .. description_delim .. description

                    if entry.source.name == "rg" then
                      icon = "";
                    end

                    if entry.source.name == "luasnip" then
                      icon = "";
                    end

                    if entry.source.name == "calc" then
                      icon = "";
                    end

                    if entry.source.name == "unicode" then
                      icon = "󰻐";
                    end

                    if entry.source.name == "copilot" then
                      icon = "";
                    end

                    format.kind = " " .. icon .. " "
                    return format
                  end
                '';
            };

            window = {
              completion = {
                scrollbar = true;
                scrolloff = 2;
                border = "rounded";
                winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None";
                col_offset = -4;
                side_padding = 0;
              };

              documentation = {
                border = "rounded";
                max_height = "math.floor(vim.o.lines / 2)";
              };
            };

            sources = mkSources (
              [
                "nvim_lsp"
                "async_path"
                "buffer"
                "calc"
                "nvim_lsp_signature_help"
                "treesitter"
                "luasnip"
                "rg"
              ]
              ++ lib.optionals config.modules.completions.unicode.enable [
                "unicode"
              ]
              ++ lib.optionals config.modules.completions.copilot.enable [
                "copilot"
              ]
            );

            sorting = {
              priority_weight = 2;
              comparators =
                lib.optionals config.modules.completions.unicode.enable [
                  # lua
                  ''
                    function(a, b)
                      local a_unicode = a.source.name == "unicode"
                      local b_unicode = b.source.name == "unicode"
                      if a_unicode and b_unicode then
                        local a_code = tonumber(a.filter_text:match("U%+(%x+)"), 16)
                        local b_code = tonumber(b.filter_text:match("U%+(%x+)"), 16)
                        return a_code < b_code
                      end
                    end
                  ''
                ]
                ++ lib.optionals config.modules.completions.copilot.enable [
                  # lua
                  ''
                    function(a, b)
                      local a_copilot = a.source.name == "copilot"
                      local b_copilot = b.source.name == "copilot"
                      if a_copilot and not b_copilot then
                        return true
                      elseif not a_copilot and b_copilot then
                        return false
                      end
                    end
                  ''
                ]
                ++ [
                  "cmp.config.compare.offset"
                  "cmp.config.compare.exact"
                  "cmp.config.compare.score"
                  "cmp.config.compare.recently_used"
                  "cmp.config.compare.kind"
                  "cmp.config.compare.length"
                  "cmp.config.compare.order"
                ];
            };

            mapping = {
              "<C-Space>" =
                # lua
                ''
                  cmp.mapping(function(_)
                    if cmp.visible() then
                      cmp.close()
                    else
                      cmp.complete()
                    end
                  end, { "i", "n", "v" })
                '';

              "<Down>" =
                # lua
                ''
                  cmp.mapping(function(fallback)
                    if not cmp.visible() then
                      fallback()
                    elseif cmp.visible() then
                      cmp.select_next_item()
                    elseif not cmp.select_next_item() and vim.bo.buftype ~= 'prompt' then
                      cmp.complete()
                    else
                      fallback()
                    end
                  end, { "i", "s" })
                '';

              "<Up>" =
                # lua
                ''
                  cmp.mapping(function(fallback)
                    if not cmp.visible() then
                      fallback()
                    elseif cmp.visible() then
                      cmp.select_prev_item()
                    elseif not cmp.select_next_item() and vim.bo.buftype ~= 'prompt' then
                      cmp.complete()
                    else
                      fallback()
                    end
                  end, { "i", "s" })
                '';

              "<CR>" =
                # lua
                ''
                  cmp.mapping({
                    i = function(fallback)
                      if cmp.visible() and cmp.get_active_entry() then
                        if luasnip.expandable() then
                          luasnip.expand()
                        else
                          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                        end
                      else
                        fallback()
                      end
                    end,
                    s = cmp.mapping.confirm({ select = false }),
                    c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                  })
                '';

              "<C-j>" =
                # lua
                ''
                  cmp.mapping.scroll_docs(-4)
                '';

              "<C-k>" =
                # lua
                ''
                  cmp.mapping.scroll_docs(4)
                '';

              "<Esc>" =
                # lua
                ''
                  cmp.mapping(function(fallback)
                    if cmp.visible() and cmp.get_active_entry() then
                      cmp.abort()
                    else
                      fallback()
                    end
                  end)
                '';
            };
          };
        };
      };

      extraConfigLuaPre =
        lib.optionalString config.modules.completions.enable
        # lua
        ''
          ---@diagnostic disable: unused-local
          local luasnip = require("luasnip")
          local lspkind = require("lspkind")
          local cmp = require("cmp")
        ''
        + lib.optionalString config.modules.completions.unicode.enable
        # lua
        ''
          UnicodeTable = {} -- populated in autocommand
          UnicodeCompletions = {} -- populated in autocommand

          function Utf8Character(hex)
            local code = tonumber(hex, 16)
            if code < 0x80 then
              return string.char(code)
            elseif code < 0x800 then
              local byte1 = 0xC0 + math.floor(code / 0x40)
              local byte2 = 0x80 + (code % 0x40)
              return string.char(byte1, byte2)
            elseif code < 0x10000 then
              local byte1 = 0xE0 + math.floor(code / 0x1000)
              local byte2 = 0x80 + (math.floor(code / 0x40) % 0x40)
              local byte3 = 0x80 + (code % 0x40)
              return string.char(byte1, byte2, byte3)
            elseif code < 0x200000 then
              local byte1 = 0xF0 + math.floor(code / 0x40000)
              local byte2 = 0x80 + (math.floor(code / 0x1000) % 0x40)
              local byte3 = 0x80 + (math.floor(code / 0x40) % 0x40)
              local byte4 = 0x80 + (code % 0x40)
              return string.format(string.char(byte1, byte2, byte3, byte4))
            else
              error("Invalid Unicode: " .. hex)
            end
          end

          function IsUtf8ControlChar(hex)
            local code = tonumber(hex, 16)

            if not code then
              return false
            end

            if
              (code >= 0x00 and code <= 0x1F)
              or (code == 0x7F)
              or (code >= 0x80 and code <= 0x9F)
            then
              return true
            end

            return false
          end

          cmp.register_source('unicode', {
            complete = function(_, _, callback)
              callback({ items = UnicodeCompletions, isIncomplete = false })
            end
          })
        '';

      autoCmd = lib.optionals config.modules.completions.unicode.enable [
        {
          event = ["VimEnter"];
          pattern = ["*"];
          callback =
            helpers.mkRaw
            # lua
            ''
              function()
                vim.defer_fn(function()
                  local unicode_file = vim.fn.stdpath('data') .. '/site/unicode/UnicodeData.txt'

                  local function should_update_unicode_table()
                    local one_month = 30 * 24 * 60 * 60

                    local stat = vim.loop.fs_stat(unicode_file)
                    if stat then
                      local age = os.time() - stat.mtime.sec
                      return age > one_month
                    end

                    return true
                  end

                  if should_update_unicode_table() then
                      vim.cmd("silent! UnicodeDownload!")
                  end

                  local file = io.open(unicode_file, "r")
                  if file then
                    local contents = file:read("*a")
                    file:close()
                    UnicodeTable = vim.tbl_filter(function(line)
                      return line ~= ""
                    end, vim.split(contents, "\n"))
                  end

                  for _, line in ipairs(UnicodeTable) do
                    local sections = vim.split(line, ";")
                    local char = Utf8Character(sections[1])
                    local hex = "U+" .. sections[1]
                    local name = sections[2]

                    if char and name and not IsUtf8ControlChar(sections[1]) then
                      table.insert(UnicodeCompletions, {
                        word = char,
                        abbr = char,
                        label = char,
                        insertText = char,
                        filterText = char .. " " .. hex .. " " .. name,
                        kind = cmp.lsp.CompletionItemKind.Text,
                        documentation = {
                          kind = "markdown",
                          value = "**" .. hex .. "** *" .. name .. "*",
                        },
                      })
                    end
                  end
                end, 1000)
              end
            '';
        }
      ];

      extraPackages = with pkgs; [
        ripgrep
      ];

      extraPlugins = with pkgs.vimPlugins; (
        [
          lspkind-nvim
        ]
        ++ lib.optionals config.modules.completions.unicode.enable [
          unicode-vim
        ]
      );
    };
}
